<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="text" encoding="utf-8" />
    <xsl:param name="delim" select="','" />
    <xsl:param name="dot" select="'.'" />
    <xsl:param name="quote" select="'&quot;'"/>
    <xsl:param name="break" select="'&#xA;'" />
    <xsl:variable name="bugType" select="/entity-engine-xml/IssueType[@name ='Bug']/@id"/>
    <xsl:variable name="custType">
        <xsl:call-template name="string-join">
            <xsl:with-param name="nodes" select="/entity-engine-xml/CustomField[contains(@name,'Additional Comments')
                                                or contains(@name,'Steps to Reproduce')
                                                or contains(@name,'Expected Result')
                                                or contains(@name,'Observed Result')]/@id"/>
            <xsl:with-param name="delimiter" select="'|'"/>
        </xsl:call-template>
    </xsl:variable>

    <xsl:template match="/">
        <xsl:message><xsl:value-of select="$custType"/></xsl:message>
        <xsl:text>bugid,comments</xsl:text><xsl:value-of select="$break" />
        <xsl:apply-templates select="entity-engine-xml/Issue"/>
    </xsl:template>

    <xsl:template match="Issue">
        <xsl:value-of select="normalize-space(@id)" /><xsl:value-of select="$delim"/><xsl:value-of select="$quote"/>
        <xsl:call-template name="action">
            <xsl:with-param name="issue" select="."/>
        </xsl:call-template>
        <xsl:value-of select="$quote"/>
        <xsl:value-of select="$break"/>
    </xsl:template>

    <xsl:template name="action">
        <xsl:param name="issue"/>
        <xsl:variable name="id" select="$issue/@id"/>
        <xsl:variable name="summary" select="$issue/@summary"/>
        <xsl:variable name="comments" select="/entity-engine-xml/Action[@issue=$id and
                                                @type='comment' and body]/body"/>
        <xsl:variable name="customField" select="/entity-engine-xml/CustomFieldValue[@issue=$id and
                                                    contains($custType,@customfield) and textvalue]/textvalue"/>
        <xsl:call-template name="string-join">
            <xsl:with-param name="nodes" select="$summary| $comments | $customField"/>
            <xsl:with-param name="delimiter" select="'&#10;'"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template name="string-join">
        <xsl:param name="nodes"/>
        <xsl:param name="delimiter" />
        <xsl:for-each select="$nodes">
            <xsl:value-of select="translate(.,$quote, '')"/>
            <xsl:if test="position() != last()">
                <xsl:value-of select="$delimiter"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>

</xsl:stylesheet>