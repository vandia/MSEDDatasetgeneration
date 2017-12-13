<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="text" encoding="utf-8" />
    <xsl:param name="delim" select="','" />
    <xsl:param name="dot" select="'.'" />
    <xsl:param name="quote" select="'&quot;'" />
    <xsl:param name="break" select="'&#xA;'" />
    <xsl:variable name="bugType" select="/entity-engine-xml/IssueType[@name='Bug']/@id"/>
    <xsl:variable name="custId" select="'10700'"/> <!--CustomField id correspondent with SourceForge Reporter field-->
    <xsl:variable name="status" select="/entity-engine-xml/Status"/>
    <xsl:variable name="dupStatus" select="/entity-engine-xml/Status[contains(@name,'Duplicate')]"/>


    <xsl:template match="/">
        <xsl:text>bugid,project,number,creation_date,reporter,sourceforge_reporter,type,priority,workflowId,version,fix_version,status,classifier</xsl:text><xsl:value-of select="$break" />
        <xsl:apply-templates select="entity-engine-xml/Issue"/>
    </xsl:template>

    <xsl:template match="Issue">
        <xsl:variable name="id" select="@id"/>
        <xsl:variable name="selected_status" select="@status"/>
        <xsl:variable name="srcfg_rep" select="/entity-engine-xml/CustomFieldValue[@issue=$id and @customfield=$custId]/@stringvalue"/>
        <xsl:value-of select="normalize-space($id)" /><xsl:value-of select="$delim"/><xsl:value-of
            select="normalize-space(@projectKey)" /><xsl:value-of select="$delim"/><xsl:value-of
            select="normalize-space(@number)" /><xsl:value-of select="$delim"/><xsl:value-of
            select="normalize-space(@created)" /><xsl:value-of select="$delim"/><xsl:value-of
            select="normalize-space(@reporter)" /><xsl:value-of select="$delim"/><xsl:value-of
            select="normalize-space($srcfg_rep)"/><xsl:value-of select="$delim"/><xsl:value-of
            select="normalize-space(@type)"/><xsl:value-of select="$delim"/><xsl:value-of
            select="normalize-space(@priority)"/><xsl:value-of select="$delim"/><xsl:value-of
            select="normalize-space(@workflowId)"/><xsl:value-of select="$delim"/><xsl:value-of
            select="sum(/entity-engine-xml/NodeAssociation[@sourceNodeEntity = 'Issue' and @sinkNodeEntity = 'Version'
            and @sourceNodeId=$id and @associationType='IssueVersion']/@sinkNodeId)"/><xsl:value-of select="$delim"/><xsl:value-of
            select="sum(/entity-engine-xml/NodeAssociation[@sourceNodeEntity = 'Issue' and @sinkNodeEntity = 'Version'
            and @sourceNodeId=$id and @associationType='IssueFixVersion']/@sinkNodeId)"/><xsl:value-of select="$delim"/><xsl:value-of
            select="normalize-space($status[@id=$selected_status]/@name)"/>
            <xsl:value-of select="$delim"/>
            <xsl:apply-templates select="@status"/>
        <xsl:value-of select="$break" />
    </xsl:template>

    <xsl:template match="@status">
        <xsl:variable name="this" select="."/>
        <xsl:choose>
            <xsl:when test="$dupStatus[@id=$this]">DUPLICATE</xsl:when>
            <xsl:otherwise>OTHER</xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="NodeAssociation[@sourceNodeEntity = 'Issue' and @sinkNodeEntity = 'Version']">
        <xsl:value-of select="normalize-space(@sinkNodeId)"/>
    </xsl:template>



</xsl:stylesheet>