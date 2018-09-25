<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:helper="urn:my-scripts">
	<xsl:template match="PurchaseOrder">
	  <PurchaseOrder Supplyer="{Supplyer}" PurchaseDate="{helper:DateTimeFormat(PurchaseDate,'dd/MM/yyyy','ddMMyyyy')}">
		<xsl:apply-templates select="PurchaseLines"/>
	  </PurchaseOrder> 
	</xsl:template>
	<xsl:template match="PurchaseLines">
	  <PurchaseLines> 
		<xsl:apply-templates/> 
	  </PurchaseLines>
	</xsl:template> 
	<xsl:template match="PurchaseLine">
	  <PurchaseLine> 
		  <xsl:for-each select="*">
			  <xsl:attribute name="{name()}">
				<xsl:value-of select="text()"/> 
			  </xsl:attribute>   
		  </xsl:for-each> 
	  </PurchaseLine> 
	</xsl:template>
	<msxsl:script language="C#" implements-prefix="helper">  
		<msxsl:using namespace="System" />
		<![CDATA[
			public string DateTimeFormat(string value,string inputFormat, string outputFormat)
			{
				DateTime tmp;
				if (DateTime.TryParseExact(value, inputFormat, System.Globalization.CultureInfo.InvariantCulture, System.Globalization.DateTimeStyles.None, out tmp))
					return tmp.ToString(outputFormat);
				else
					return null;
			}
		]]>
	</msxsl:script> 
</xsl:stylesheet>