<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="text" encoding="utf-8" />
    <xsl:param name="delim" select="','" />
    <xsl:param name="dot" select="'.'" />
    <xsl:param name="quote" select="'&quot;'" />
    <xsl:param name="break" select="'&#xA;'" />

    <xsl:template match="/">
        <xsl:text>id,directoryId,userName,lowerUserName,active,createdDate,updatedDate,displayName,lowerDisplayName,emailAddress,lowerEmailAddress,credential,localServiceDeskUser</xsl:text><xsl:value-of select="$break" />
        <xsl:apply-templates select="entity-engine-xml/User"/>
    </xsl:template>

    <xsl:template match="User">
        <xsl:value-of select="normalize-space(@id)" /><xsl:value-of select="$delim"/><xsl:value-of
            select="normalize-space(@directoryId)" /><xsl:value-of select="$delim"/><xsl:value-of
            select="normalize-space(@userName)" /><xsl:value-of select="$delim"/><xsl:value-of
            select="normalize-space(@lowerUserName)" /><xsl:value-of select="$delim"/><xsl:value-of
            select="normalize-space(@active)"/><xsl:value-of select="$delim"/><xsl:value-of
            select="normalize-space(@createdDate)"/><xsl:value-of select="$delim"/><xsl:value-of
            select="normalize-space(@updatedDate)" /><xsl:value-of select="$delim"/><xsl:value-of
            select="normalize-space(@displayName)" /><xsl:value-of select="$delim"/><xsl:value-of
            select="normalize-space(@lowerDisplayName)" /><xsl:value-of select="$delim"/><xsl:value-of
            select="normalize-space(@emailAddress)" /><xsl:value-of select="$delim"/><xsl:value-of
            select="normalize-space(@lowerEmailAddress)" /><xsl:value-of select="$delim"/><xsl:value-of
            select="normalize-space(@credential)" /><xsl:value-of select="$delim"/><xsl:value-of
            select="normalize-space(@localServiceDeskUser)"/>
        <xsl:value-of select="$break" />
    </xsl:template>

</xsl:stylesheet>