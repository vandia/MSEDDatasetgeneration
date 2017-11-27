<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="text" encoding="utf-8" />
    <xsl:param name="delim" select="','" />
    <xsl:param name="dot" select="'.'" />
    <xsl:param name="quote" select="'&quot;'" />
    <xsl:param name="break" select="'&#xA;'" />
    <xsl:variable name="dupStatus" select="/entity-engine-xml/Status[contains(@description,'Duplicate')]/@id"/>

    <xsl:template match="/">
        <xsl:text>bugid,project,reporter,summary,status</xsl:text><xsl:value-of select="$break" />
        <xsl:apply-templates select="entity-engine-xml/Issue"/>
    </xsl:template>



</xsl:stylesheet>