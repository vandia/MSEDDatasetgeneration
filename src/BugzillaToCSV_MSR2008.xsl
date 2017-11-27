<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="text" encoding="utf-8" />
    <xsl:param name="delim" select="','" />
    <xsl:param name="dot" select="'.'" />
    <xsl:param name="quote" select="'&quot;'" />
    <xsl:param name="break" select="'&#xA;'" />
    <xsl:template match="/">
        <xsl:apply-templates select="bugzilla/bug[not(@error)]"/>
    </xsl:template>

    <xsl:template match="bug">
        <xsl:value-of
            select="normalize-space(bug_id)" /><xsl:value-of select="$delim"/><xsl:value-of
            select="normalize-space(creation_ts)" /><xsl:value-of select="$delim"/><xsl:value-of
            select="normalize-space(delta_ts)" /><xsl:value-of select="$delim"/><xsl:value-of
            select="normalize-space(classification)" /><xsl:value-of select="$delim"/><xsl:value-of
            select="normalize-space(product)"/><xsl:value-of select="$delim"/><xsl:value-of
            select="normalize-space(component)"/><xsl:value-of select="$delim"/><xsl:value-of
            select="concat($quote, normalize-space(version), $quote)" /><xsl:value-of select="$delim"/><xsl:value-of
            select="normalize-space(op_sys)" /><xsl:value-of select="$delim"/><xsl:value-of
            select="normalize-space(bug_status)" /><xsl:value-of select="$delim"/><xsl:value-of
            select="normalize-space(resolution)" /><xsl:value-of select="$delim"/><xsl:value-of
            select="normalize-space(priority)" /><xsl:value-of select="$delim"/><xsl:value-of
            select="normalize-space(bug_severity)" /><xsl:value-of select="$delim"/><xsl:value-of
            select="normalize-space(target_milestone)" /><xsl:value-of select="$delim"/><xsl:value-of
            select="concat($quote, normalize-space(reporter), $quote)" /><xsl:value-of select="$delim"/><xsl:value-of
            select="concat($quote, normalize-space(assigned_to), $quote)" />
        <xsl:value-of select="$break" />
    </xsl:template>

</xsl:stylesheet>