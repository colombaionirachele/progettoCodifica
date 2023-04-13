<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" version="1.0">
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>

    <!--
         Progetto esame-corso Codifica di testi 22-23
         Studentessa: Rachele Colombaioni
    -->
    <!--Costruzione pagina html: menù, body, footer--> 
    <xsl:template match="/">
        
        <html>
            <head>
                <title><xsl:value-of select="tei:teiCorpus/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"/>- <xsl:value-of select="tei:teiCorpus/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:respStmt/tei:persName"/></title>
                <script src="https://code.jquery.com/jquery-3.3.1.min.js" type="text/javascript"/> 
                <link rel="stylesheet" href="style.css"/>
            </head>
            <body>
                <h1>
                    <xsl:value-of select="tei:teiCorpus/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"/>
                </h1>
                <header>
                    <a id="intro_link" href="#intro">Introduzione</a>
                    <!-- BOTTONI PER ATTIVARE LA VISTA DELLE CARTOLINE -->
                    <a class="view" href="#28">Cartolina 28</a>
                    <a class="view" href="#32">Cartolina 32</a>
                    <a id="about_link" href="#about">About</a>
                </header>
                <main>
                    <div class="header">
                        
                        <h3><strong>Provenienza cartoline:</strong></h3>
                        
                        <h3><xsl:value-of select="tei:teiCorpus/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:msIdentifier/tei:repository"/>,</h3>
                        <h3> a: <xsl:value-of select="tei:teiCorpus/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:msIdentifier/tei:settlement"/>,
                            <xsl:value-of select="tei:teiCorpus/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:msIdentifier/tei:country"/></h3>
                    </div>  
                    <xsl:element name="img">
                        <xsl:attribute name="src">immagini/pattern1.png</xsl:attribute>
                        <xsl:attribute name="class">divisore</xsl:attribute>
                    </xsl:element>
                    <div class="view" id="28">
                        <xsl:apply-templates select="/tei:teiCorpus/tei:TEI[1]"/>
                    </div>
                    <xsl:element name="img">
                        <xsl:attribute name="src">immagini/pattern1.png</xsl:attribute>
                        <xsl:attribute name="class">divisore</xsl:attribute>
                    </xsl:element>
                    <div class="view" id="32">
                        <xsl:apply-templates select="/tei:teiCorpus/tei:TEI[2]"/>
                    </div>
                    <xsl:element name="img">
                        <xsl:attribute name="src">immagini/pattern1.png</xsl:attribute>
                        <xsl:attribute name="class">divisore</xsl:attribute>
                    </xsl:element>
                </main>              
                <footer>
                    <div id="about" class="footer_text">
                        <p class="footer">Progetto esame di Codifica di Testi a.a. 2022/2023</p>
                        <p class="footer"> <xsl:value-of select="tei:teiCorpus/tei:teiHeader/tei:fileDesc/tei:editionStmt/tei:edition"/></p>
                        <p class="footer"><xsl:apply-templates select="//tei:editionStmt/tei:respStmt"/></p>
                        
                    </div>
                </footer>
            </body>
        </html>
    </xsl:template>
    
    
    
    <!-- Contenitore singole cartoline -->
    <xsl:template match="//tei:TEI">
        <xsl:element name="div"> 
            <xsl:attribute name="id">
                <xsl:value-of select="concat('cart', '')"/>
                <xsl:number level="any"/> 
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <!-- titolo cartolina e nota introduttiva -->
    <xsl:template match="tei:TEI/tei:teiHeader">
        <h2 class="not1"><b>Titolo dell'opera: </b><xsl:value-of select="tei:fileDesc/tei:sourceDesc/tei:bibl/tei:title"/></h2>
        <p class="not"><b>Rappresentazione: </b><xsl:value-of select="tei:profileDesc/tei:textClass/tei:keywords/tei:term[3]"/></p>
        <p class="not"><b>Note: </b><xsl:value-of select="tei:profileDesc/tei:textClass/tei:keywords/tei:term[2]"/>,<xsl:value-of select="tei:fileDesc/tei:notesStmt/tei:note"/></p>
        <xsl:element name="p">
            <b>Materiale:</b><xsl:value-of select="tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:physDesc/tei:objectDesc/tei:supportDesc/tei:support/tei:material"/>
            <b>Condizioni:</b><xsl:value-of select="tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:physDesc/tei:objectDesc/tei:supportDesc/tei:condition/tei:p"/>
            <b>Dimensioni:</b><xsl:value-of select="tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:physDesc/tei:objectDesc/tei:supportDesc/tei:support/tei:dimensions/tei:height"/>x<xsl:value-of select="tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:physDesc/tei:objectDesc/tei:supportDesc/tei:support/tei:dimensions/tei:width"/>
        </xsl:element>
    </xsl:template>
    
    <!-- visualizzazione delle immagini mappate-->
    <xsl:template match="//tei:facsimile/tei:surface">
        <xsl:element name="div">
            <xsl:attribute name="class">contimg</xsl:attribute>
            <xsl:element name="div">
                <xsl:attribute name="class">img</xsl:attribute>
                <xsl:element name="img">    
                    <xsl:attribute name="src">
                        <xsl:value-of select="tei:graphic/@url"/>
                    </xsl:attribute>     
                    <xsl:apply-templates/>        
                </xsl:element>
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    
 <!--caratterizzazione con info le cartoline-->
    <xsl:template match="tei:figure">
        <xsl:element name="div">
            <xsl:attribute name="class">fronte</xsl:attribute>
            <xsl:element name="p">
                <xsl:text>FRONTE: </xsl:text> 
            </xsl:element>   
            <xsl:value-of select="tei:figDesc[1]"/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="//tei:div[@type='retro']">
        <xsl:element name="div">
            <xsl:attribute name="class">retro</xsl:attribute>
            <xsl:element name="p">
                <xsl:text>RETRO: </xsl:text> 
            </xsl:element>   
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="//tei:div[@type='tipografia']">
        <xsl:element name="div">
            <xsl:attribute name="class">tipografia</xsl:attribute>
            <xsl:element name="p">
                <xsl:text>Tipografia stampa: </xsl:text> 
            </xsl:element>   
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template> 
    
    <!--Configurazione footer con edizione e pubblicazione-->
    <xsl:template match="tei:teiHeader/tei:fileDesc">
        <div class="edizione">
            <xsl:apply-templates select="tei:editionStmt/tei:respStmt"/>
        </div>
        <div class="pubblicazione">
            <xsl:apply-templates select="tei:publicationStmt"/>
        </div>
    </xsl:template>
    
    
    
</xsl:stylesheet>