<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="text"/>
    <xsl:template name="string-replace-all">
        <xsl:param name="text"/>
        <xsl:variable name="apos1">'</xsl:variable>
        <xsl:variable name="apos2">''</xsl:variable>
        <xsl:choose>
            <xsl:when test="contains($text, $apos1)">
                <xsl:value-of select="substring-before($text, $apos1)"/>
                <xsl:value-of select="$apos2"/>
                <xsl:call-template name="string-replace-all">
                    <xsl:with-param name="text" select="substring-after($text, $apos1)"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$text"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="/">
        <xsl:for-each select="games/game">
            <xsl:variable name="name">
                <xsl:call-template name="string-replace-all">
                    <xsl:with-param name="text" select="name"/>
                </xsl:call-template>
            </xsl:variable>
            <xsl:variable name="short">
                <xsl:call-template name="string-replace-all">
                    <xsl:with-param name="text" select="short"/>
                </xsl:call-template>
            </xsl:variable>
            <xsl:variable name="author">
                <xsl:call-template name="string-replace-all">
                    <xsl:with-param name="text" select="author"/>
                </xsl:call-template>
            </xsl:variable>
            <xsl:variable name="portauthor">
                <xsl:call-template name="string-replace-all">
                    <xsl:with-param name="text" select="portauthor"/>
                </xsl:call-template>
            </xsl:variable>
            <xsl:variable name="description">
                <xsl:call-template name="string-replace-all">
                    <xsl:with-param name="text" select="description"/>
                </xsl:call-template>
            </xsl:variable>INSERT INTO applications (name, short, icon, link, preview, date, author, portauthor, homepage, description) VALUES ('<xsl:value-of select="$name"/>', '<xsl:value-of select="$short"/>', '<xsl:value-of select="icon"/>', '<xsl:value-of select="link"/>', '<xsl:value-of select="preview"/>', '<xsl:value-of select="date"/>', '<xsl:value-of select="$author"/>', '<xsl:value-of select="$portauthor"/>', '<xsl:value-of select="homepage"/>', '<xsl:value-of select="$description"/>');
</xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
