<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:base="http://xmlns.com/foaf/0.1/" xmlns:bio="http://purl.org/vocab/bio/0.1/" xmlns:sioc="http://rdfs.org/sioc/ns#">
	<xsl:output method="html" encoding="utf-8"/>
	<xsl:template match="/">
		<html>
			<head>
				<title>FOAF</title>
				<style type="text/css">
					body {
                    background-color:#222222 ;
                    border:solid 1px #333333;
					}
                
					a {
						color:#fce4a1;
						text-decoration:none;
					}
				</style>
			</head>
			<body style="padding:5px;margin:0;">
				<div style="overflow-y:auto; width:100%; height:288px; color:white; font-family:'Lucida Grande'; ">
					<div style="float:left; width:110px;">
						<img width="96" height="96">
							<xsl:attribute name="src">
								<xsl:value-of select="rdf:RDF/base:Agent/base:img/base:Image/base:thumbnail/base:Image/@rdf:about"/>
							</xsl:attribute>
						</img>
					</div>
					<div style="float:left; width:288px; ">
						<p style="padding-top:0;margin-top:0;">
							<strong>
								<a>
									<xsl:attribute name="href">
										<xsl:value-of select="rdf:RDF/base:Agent/base:account/base:OnlineAccount/base:accountProfilePage/@rdf:resource"/>
									</xsl:attribute>
									<xsl:value-of select="rdf:RDF/base:Agent/base:account/base:OnlineAccount/base:accountName"/>
								</a>
								<span style="margin-left:5px;">(</span>
								<span>
									<xsl:value-of select="rdf:RDF/base:Agent/base:name"/>
								</span>
								<span>)</span>
							</strong>
						</p>
						<p>
							<a>
								<xsl:attribute name="href">
									<xsl:value-of select="rdf:RDF/base:Agent/base:homepage/@rdf:resource"/>
								</xsl:attribute>
								<xsl:value-of select="rdf:RDF/base:Agent/base:homepage/@rdf:resource"/>
							</a>
						</p>
						<p style="line-height:1.5em;">
							<xsl:value-of select="rdf:RDF/base:Agent/bio:olb"/>
						</p>
                        <ul style="list-style:none; padding:0; line-height:1.5em;">
                            <xsl:for-each select="rdf:RDF/base:Agent">
                                <li>
                                    <a>
                                        <xsl:attribute name="href">
											<xsl:value-of select="base:account/base:OnlineAccount/base:accountProfilePage/@rdf:resource" />
                                        </xsl:attribute>
                                        <xsl:value-of select="base:account/base:OnlineAccount/base:accountName" />
                                    </a>
                                </li>
                            </xsl:for-each>
                        </ul>
					</div>
				</div>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
