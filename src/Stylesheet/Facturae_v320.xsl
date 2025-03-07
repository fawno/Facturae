<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:m="http://www.facturae.es/Facturae/2009/v3.2/Facturae" xmlns:ds="http://www.w3.org/2000/09/xmldsig#" xmlns:tns="http://schemas.xmlsoap.org/soap/envelope/">
	<xsl:output method="html" indent="yes"/>
	<xsl:decimal-format grouping-separator="." decimal-separator=","/>
	<xsl:template match="/">
		<html>
			<head>

				<style type="text/css">
					BODY
					{
						SCROLLBAR-FACE-COLOR: lightsteelblue;
						FONT-SIZE: 10pt;
						SCROLLBAR-HIGHLIGHT-COLOR: lightsteelblue;
						COLOR: #000000;
						SCROLLBAR-3DLIGHT-COLOR: darkblue;
						TEXT-INDENT: 5pt;
						SCROLLBAR-ARROW-COLOR: darkblue;
						SCROLLBAR-TRACK-COLOR: #e8efff;
						FONT-FAMILY: Arial, Helvetica, sans-serif;
						SCROLLBAR-DARKSHADOW-COLOR: lightsteelblue;
						BACKGROUND-COLOR: #ffffff;
						TEXT-ALIGN: justify
					}
					.titulo1
					{
						FONT-WEIGHT: bold;
						FONT-SIZE: 15px;
						COLOR: #000080;
						TEXT-ALIGN: center
					}
					.titulo2
					{
						FONT-WEIGHT: bold;
						FONT-SIZE: 14px;
						COLOR: #800000;
						TEXT-ALIGN: center
					}
					.titulopeque
					{
						FONT-WEIGHT: bold;
						FONT-SIZE: 11px;
						COLOR: #000000;
						FONT-FAMILY: Arial, Helvetica, sans-serif
					}
					.letrita
					{
						FONT-SIZE: 8pt
					}
					TABLE
					{
						FONT-SIZE: 9pt;
						FONT-FAMILY: Arial,Helvetica,sans-serif
					}
					TR
					{
						FONT-SIZE: 10pt;
						FONT-FAMILY: Arial
					}
					TD
					{
						FONT-SIZE: 10px;
						FONT-FAMILY: Arial,Helvetica,sans-serif
					}
					HR
					{
						COLOR: #003399;
						TEXT-ALIGN: center
					}
				</style>

				<script>
					function mostrarCapa(capa)
					{
						var datos = document.getElementById(capa).style.display;
						if (datos != "none")
						{
							document.getElementById(capa + "Link").innerHTML = "Mostrar más datos";
							document.getElementById(capa).style.display="none";
						}
						else
						{
							document.getElementById(capa + "Link").innerHTML = "Ocultar";
							document.getElementById(capa).style.display="";
						}
					}
					function mostrarFactura(numFactura)
					{
						var datos = document.getElementById(numFactura).style.display;
						if (datos != "none")
						{
							document.getElementById("lote").style.display="";
							document.getElementById("importesLote").style.display="";
							if (document.getElementById("tercero")!=null)
							{
								document.getElementById("tercero").style.display="";
							}
							document.getElementById("listadoFacturas").style.display="";
							document.getElementById("factura" + numFactura).style.display="none";
							document.getElementById(numFactura).style.display="none";
						}
						else
						{
							document.getElementById("lote").style.display="none";
							document.getElementById("importesLote").style.display="none";
							if (document.getElementById("tercero")!=null)
							{
								document.getElementById("tercero").style.display="none";
							}
							document.getElementById("listadoFacturas").style.display="none";
							document.getElementById("factura" + numFactura).style.display="";
							document.getElementById(numFactura).style.display="";
						}
					}
					function mostrarDetalle(numFactura,desDetalle)
					{
						var datos = document.getElementById(numFactura + "_" + desDetalle).style.display;
						if (datos != "none")
						{
							document.getElementById("emisor").style.display="";
							document.getElementById("receptor").style.display="";
							if (document.getElementById("cesionario")!=null)
							{
								document.getElementById("cesionario").style.display="";
							}
							document.getElementById("factura" + numFactura).style.display="";
							document.getElementById(numFactura).style.display="";
							document.getElementById(numFactura + "_" + desDetalle).style.display="none";
						}
						else
						{
							document.getElementById("lote").style.display="none";
							document.getElementById("importesLote").style.display="none";
							document.getElementById("emisor").style.display="none";
							document.getElementById("receptor").style.display="none";
							if (document.getElementById("tercero")!=null)
							{
								document.getElementById("tercero").style.display="none";
							}
							if (document.getElementById("cesionario")!=null)
							{
								document.getElementById("cesionario").style.display="none";
							}
							document.getElementById("listadoFacturas").style.display="none";
							document.getElementById("factura" + numFactura).style.display="none";
							document.getElementById(numFactura).style.display="none";
							document.getElementById(numFactura + "_" + desDetalle).style.display="";
						}
					}

					function descUnidadMedida(valor)
					{
						var descripcion = '';
						switch(valor) {
							case '01':
								descripcion = 'Unidades';
								break;
							case '02':
								descripcion = 'Horas-HUR';
								break;
							case '03':
								descripcion = 'Kilogramos-KGM';
								break;
							case '04':
								descripcion = 'Litros-LTR';
								break;
							case '05':
								descripcion = 'Otros';
								break;
							case '06':
								descripcion = 'Cajas-BX';
								break;
							case '07':
								descripcion = 'Bandejas-DS';
								break;
							case '08':
								descripcion = 'Barriles-BA';
								break;
							case '09':
								descripcion = 'Bidones-JY';
								break;
							case '10':
								descripcion = 'Bolsas-BG';
								break;
							case '11':
								descripcion = 'Bombonas-CO';
								break;
							case '12':
								descripcion = 'Botellas-BO';
								break;
							case '13':
								descripcion = 'Botes-CI';
								break;
							case '14':
								descripcion = 'Tetra Briks';
								break;
							case '15':
								descripcion = 'Centilitros-CLT';
								break;
							case '16':
								descripcion = 'Centímetros-CMT';
								break;
							case '17':
								descripcion = 'Cubos-BI';
								break;
							case '18':
								descripcion = 'Docenas';
								break;
							case '19':
								descripcion = 'Estuches-CS';
								break;
							case '20':
								descripcion = 'Garrafas-DJ';
								break;
							case '21':
								descripcion = 'Gramos-GRM';
								break;
							case '22':
								descripcion = 'Kilómetros-KMT';
								break;
							case '23':
								descripcion = 'Latas-CA';
								break;
							case '24':
								descripcion = 'Manojos-BH';
								break;
							case '25':
								descripcion = 'Metros-MTR';
								break;
							case '26':
								descripcion = 'Milímetros-MMT';
								break;
							case '27':
								descripcion = '6-Packs';
								break;
							case '28':
								descripcion = 'Paquetes-PK';
								break;
							case '29':
								descripcion = 'Raciones';
								break;
							case '30':
								descripcion = 'Rollos-RO';
								break;
							case '31':
								descripcion = 'Sobres-EN';
								break;
							case '32':
								descripcion = 'Tarrinas-TB';
								break;
							case '33':
								descripcion = 'Metro cúbico-MTQ';
								break;
							case '34':
								descripcion = 'Segundo-SEC';
								break;
							case '35':
								descripcion = 'Vatio-WTT';
								break;
							default:
								descripcion = valor;
								break;
						}
						return descripcion;
					}

					function descTipoPersona(valor)
					{
						var descripcion = '';
						switch(valor) {
							case 'F':
								descripcion = 'Física';
								break;
							case 'J':
								descripcion = 'Jurídica';
								break;
							default:
								descripcion = valor;
								break;
						}
						return descripcion;
					}

					function descTipoResidencia(valor)
					{
						var descripcion = '';
						switch(valor) {
							case 'E':
								descripcion = 'Extranjero';
								break;
							case 'R':
								descripcion = 'Residente';
								break;
							case 'U':
								descripcion = 'Residente en la Unión Europea';
								break;
							default:
								descripcion = valor;
								break;
						}
						return descripcion;
					}

					function descTipoRol(valor)
					{
						var descripcion = '';
						switch(valor) {
							case '01':
								descripcion = 'Fiscal';
								break;
							case '02':
								descripcion = 'Receptor';
								break;
							case '03':
								descripcion = 'Pagador';
								break;
							case '04':
								descripcion = 'Comprador';
								break;
							case '05':
								descripcion = 'Cobrador';
								break;
							case '06':
								descripcion = 'Vendedor';
								break;
							case '07':
								descripcion = 'Receptor del pago';
								break;
							case '08':
								descripcion = 'Receptor del cobro';
								break;
							case '09':
								descripcion = 'Emisor';
								break;
							default:
								descripcion = valor;
								break;
						}
						return descripcion;
					}

					function descFormaPago(valor)
					{
						var descripcion = '';
						switch(valor) {
							case '01':
								descripcion = 'Al contado';
								break;
							case '02':
								descripcion = 'Recibo Domiciliado';
								break;
							case '03':
								descripcion = 'Recibo';
								break;
							case '04':
								descripcion = 'Transferencia';
								break;
							case '05':
								descripcion = 'Letra Aceptada';
								break;
							case '06':
								descripcion = 'Crédito Documentario';
								break;
							case '07':
								descripcion = 'Contrato Adjudicación';
								break;
							case '08':
								descripcion = 'Letra de cambio';
								break;
							case '09':
								descripcion = 'Pagaré a la  Orden';
								break;
							case '10':
								descripcion = 'Pagaré No a la Orden';
								break;
							case '11':
								descripcion = 'Cheque';
								break;
							case '12':
								descripcion = 'Reposición';
								break;
							case '13':
								descripcion = 'Especiales';
								break;
							case '14':
								descripcion = 'Compensación';
								break;
							case '15':
								descripcion = 'Giro postal';
								break;
							case '16':
								descripcion = 'Cheque conformado';
								break;
							case '17':
								descripcion = 'Cheque bancario';
								break;
							case '18':
								descripcion = 'Pago contra reembolso';
								break;
							case '19':
								descripcion = 'Pago mediante tarjeta';
								break;
							default:
								descripcion = valor;
								break;
						}
						return descripcion;
					}

					function descTipoImpuesto(valor)
					{
						var descripcion = '';
						switch(valor) {
							case '01':
								descripcion = 'IVA';
								break;
							case '02':
								descripcion = 'IPSI';
								break;
							case '03':
								descripcion = 'IGIC';
								break;
							case '04':
								descripcion = 'IRPF';
								break;
							case '05':
								descripcion = 'Otro';
								break;
							case '06':
								descripcion = 'ITPAJD';
								break;
							case '07':
								descripcion = 'IE';
								break;
							case '08':
								descripcion = 'Ra';
								break;
							case '09':
								descripcion = 'IGTECM';
								break;
							case '10':
								descripcion = 'IECDPCAC';
								break;
							case '11':
								descripcion = 'IIIMAB';
								break;
							case '12':
								descripcion = 'ICIO';
								break;
							case '13':
								descripcion = 'IMVDN';
								break;
							case '14':
								descripcion = 'IMSN';
								break;
							case '15':
								descripcion = 'IMGSN';
								break;
							case '16':
								descripcion = 'IMPN';
								break;
							case '17':
								descripcion = 'REIVA';
								break;
							case '18':
								descripcion = 'REIGIC';
								break;
							case '19':
								descripcion = 'REIPSI';
								break;
							default:
								descripcion = valor;
								break;
						}
						return descripcion;
					}

					function descLengua(valor)
					{
						var descripcion = '';
						switch(valor) {
							case 'ar':
								descripcion = 'Arabe';
								break;
							case 'be':
								descripcion = 'Bielorruso';
								break;
							case 'bg':
								descripcion = 'Búlgaro';
								break;
							case 'ca':
								descripcion = 'Catalán';
								break;
							case 'cs':
								descripcion = 'Checo';
								break;
							case 'da':
								descripcion = 'Danés';
								break;
							case 'de':
								descripcion = 'Alemán';
								break;
							case 'el':
								descripcion = 'Griego moderno';
								break;
							case 'en':
								descripcion = 'Inglés';
								break;
							case 'es':
								descripcion = 'Español';
								break;
							case 'et':
								descripcion = 'Estonio';
								break;
							case 'eu':
								descripcion = 'Vascuence';
								break;
							case 'fi':
								descripcion = 'Finlandés';
								break;
							case 'fr':
								descripcion = 'Francés';
								break;
							case 'ga':
								descripcion = 'Gaélico de Irlanda';
								break;
							case 'gl':
								descripcion = 'Gallego';
								break;
							case 'hr':
								descripcion = 'Croata';
								break;
							case 'hu':
								descripcion = 'Húngaro';
								break;
							case 'is':
								descripcion = 'Islandés';
								break;
							case 'it':
								descripcion = 'Italiano';
								break;
							case 'lv':
								descripcion = 'Letón';
								break;
							case 'lt':
								descripcion = 'Lituano';
								break;
							case 'mk':
								descripcion = 'Macedonio';
								break;
							case 'mt':
								descripcion = 'Maltés';
								break;
							case 'nl':
								descripcion = 'Neerlandés';
								break;
							case 'no':
								descripcion = 'Noruego';
								break;
							case 'pl':
								descripcion = 'Polaco';
								break;
							case 'pt':
								descripcion = 'Portugués';
								break;
							case 'ro':
								descripcion = 'Rumano';
								break;
							case 'ru':
								descripcion = 'Ruso';
								break;
							case 'sk':
								descripcion = 'Eslovaco';
								break;
							case 'sl':
								descripcion = 'Esloveno';
								break;
							case 'sq':
								descripcion = 'Albanés';
								break;
							case 'sr':
								descripcion = 'Serbio';
								break;
							case 'sv':
								descripcion = 'Sueco';
								break;
							case 'tr':
								descripcion = 'Turco';
								break;
							case 'uk':
								descripcion = 'Ucraniano';
								break;
							default:
								descripcion = valor;
								break;
						}
						return descripcion;
					}
				</script>
			</head>
			<xsl:apply-templates select="//m:Facturae"/>
		</html>
	</xsl:template>
	<!-- Versión 3.2 -->
	<xsl:template match="m:Facturae">
			<body>
					<div id="principal">
					<center>
						<table border="0" width="90%" cellpadding="0" cellspacing="0">
							<tr  id="lote">
								<td width="100%">
									<table border="0" cellpadding="0" cellspacing="0" width="100%">
										<tr>
											<td align="center" colspan="2">

											</td>
										</tr>
										<tr>
											<td colspan="3">&#160;</td>
										</tr>
										<tr>
											<td width="100%">
												<table border="1" cellpadding="0" cellspacing="0" width="100%">
													<tr>
														<td>
															<table border="0" cellpadding="0" cellspacing="0" width="100%">
																<tr>
																	<td align="center" width="33%">
																		<font class="titulopeque">NÚMERO</font>
																		<br/><xsl:value-of select="FileHeader/Batch/BatchIdentifier"/></td>
																	<td align="center" width="34%">
																		<font class="titulopeque">VERSIÓN</font>
																		<br/>
																			<xsl:value-of select="FileHeader/SchemaVersion"/></td>
																	<td align="center" width="33%">
																		<font class="titulopeque">MODALIDAD</font>
																		<br/><xsl:choose>
																			<xsl:when test='FileHeader/Modality="I"' >
																				INDIVIDUAL
																			</xsl:when>
																			<xsl:when test='FileHeader/Modality="L"' >
																				LOTE
																			</xsl:when>
																			<xsl:otherwise>
																				<xsl:value-of select="FileHeader/Modality"/>
																			</xsl:otherwise>
																		</xsl:choose></td>
																</tr>
															</table>
														</td>
													</tr>
													<tr>
														<td>
															<table border="0" cellpadding="0" cellspacing="0" width="100%">
																<tr>
																	<td align="center" width="50%">
																		<font class="titulopeque">EMISOR DE LA FACTURA</font>
																		<br/><xsl:choose>
																			<xsl:when test='FileHeader/InvoiceIssuerType="EM"' >
																				EMISOR
																			</xsl:when>
																			<xsl:when test='FileHeader/InvoiceIssuerType="RE"' >
																				RECEPTOR
																			</xsl:when>
																			<xsl:when test='FileHeader/InvoiceIssuerType="TE"' >
																				TERCERO
																			</xsl:when>
																			<xsl:otherwise>
																				<xsl:value-of select="FileHeader/InvoiceIssuerType"/>
																			</xsl:otherwise>
																		</xsl:choose></td>
																	<td align="center" width="50%">
																		<font class="titulopeque">MONEDA DE FACTURACIÓN</font>
																		<br/><xsl:value-of select="FileHeader/Batch/InvoiceCurrencyCode"/></td>

																</tr>
															</table>
														</td>
													</tr>
												</table>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<xsl:for-each select="Invoices/Invoice">
								<xsl:variable name="nFactura" select="InvoiceHeader/InvoiceNumber"/>
								<tr  id="factura{$nFactura}" style="">
									<td width="100%">
										<table border="0" cellpadding="0" cellspacing="0" width="100%">
											<tr>
												<td align="center">
													<font class="titulo1">FACTURA NÚMERO <xsl:value-of select="$nFactura"/></font>
												</td>
											</tr>
											<tr>
												<td align="right">

												</td>
											</tr>
										</table>
									</td>
								</tr>
							</xsl:for-each>
							<tr  id="importesLote">
								<td width="100%">
									<table border="0" cellpadding="0" cellspacing="0" width="100%">
										<tr>
											<td>&#160;</td>
										</tr>
										<tr>
											<td>
												<hr/>
											</td>
										</tr>
										<tr>
											<td>
												<font class="titulo2">IMPORTES</font>
											</td>
										</tr>
										<tr>
											<td>&#160;</td>
										</tr>
										<tr>
											<td align="right">
												<xsl:if test='FileHeader/Batch/InvoiceCurrencyCode!="EUR"' >
													<table border="1" cellpadding="0" cellspacing="0" width="60%">
														<tr>
															<td width="50%" valign="top" align="center">
																&#160;&#160;&#160;
															</td>
															<td width="25%" valign="top" align="center">
																<font class="titulopeque">IMPORTE</font>
															</td>
															<td width="25%" valign="top" align="center">
																<font class="titulopeque">CONTRAVALOR</font>
															</td>
														</tr>
														<tr>
															<td width="50%" valign="top" align="right">
																<font class="titulopeque">IMPORTE TOTAL FACTURAS&#160;&#160;&#160;&#160;&#160;</font>
															</td>
															<td width="25%" valign="top">
																<table border="0" cellpadding="0" cellspacing="0" width="100%">
																	<tr>
																		<td width="100%" align="right">
																			<xsl:value-of select="FileHeader/Batch/TotalInvoicesAmount/TotalAmount"/>
																		</td>
																	</tr>
																</table>
															</td>
															<td width="25%" valign="top">
																<table border="0" cellpadding="0" cellspacing="0" width="100%">
																	<tr>
																		<td align="right">
																			<xsl:value-of select="FileHeader/Batch/TotalInvoicesAmount/EquivalentInEuros"/>
																		</td>
																	</tr>
																</table>
															</td>
														</tr>
														<tr>
															<td width="50%" valign="top" align="right">
																<font class="titulopeque">IMPORTE TOTAL A PAGAR&#160;&#160;&#160;&#160;&#160;</font>
															</td>
															<td width="25%" valign="top">
																<table border="0" cellpadding="0" cellspacing="0" width="100%">
																	<tr>
																		<td width="100%" align="right">
																			<xsl:value-of select="FileHeader/Batch/TotalOutstandingAmount/TotalAmount"/>
																		</td>
																	</tr>
																</table>
															</td>
															<td width="25%" valign="top">
																<table border="0" cellpadding="0" cellspacing="0" width="100%">
																	<tr>
																		<td align="right">
																			<xsl:value-of select="FileHeader/Batch/TotalOutstandingAmount/EquivalentInEuros"/>
																		</td>
																	</tr>
																</table>
															</td>
														</tr>
														<tr>
															<td width="50%" valign="top" align="right">
																<font class="titulopeque">IMPORTE TOTAL A EJECUTAR&#160;&#160;&#160;&#160;&#160;</font>
															</td>
															<td width="25%" valign="top">
																<table border="0" cellpadding="0" cellspacing="0" width="100%">
																	<tr>
																		<td width="100%" align="right">
																			<xsl:value-of select="FileHeader/Batch/TotalExecutableAmount/TotalAmount"/>
																		</td>
																	</tr>
																</table>
															</td>
															<td width="25%" valign="top">
																<table border="0" cellpadding="0" cellspacing="0" width="100%">
																	<tr>
																		<td align="right">
																			<xsl:value-of select="FileHeader/Batch/TotalExecutableAmount/EquivalentInEuros"/>
																		</td>
																	</tr>
																</table>
															</td>
														</tr>
													</table>
												</xsl:if>
												<xsl:if test='//m:Facturae/FileHeader/Batch/InvoiceCurrencyCode="EUR"' >
													<table border="0" cellpadding="0" cellspacing="0" width="100%">
														<tr>
															<td width="80%" align="right">
																<font class="titulopeque">IMPORTE TOTAL FACTURAS&#160;&#160;&#160;&#160;&#160;</font>
															</td>
															<td width="20%" align="center">
																<table border="1" cellpadding="0" cellspacing="0" width="100%">
																	<tr>
																		<td align="right">
																				<xsl:value-of select="FileHeader/Batch/TotalInvoicesAmount/TotalAmount"/>
																		</td>
																	</tr>
																</table>
															</td>
														</tr>
													</table>
													<table border="0" cellpadding="0" cellspacing="0" width="100%">
														<tr>
															<td width="80%" align="right">
																<font class="titulopeque">IMPORTE TOTAL A PAGAR&#160;&#160;&#160;&#160;&#160;</font>
															</td>
															<td width="20%" align="center">
																<table border="1" cellpadding="0" cellspacing="0" width="100%">
																	<tr>
																		<td align="right">
																				<xsl:value-of select="FileHeader/Batch/TotalOutstandingAmount/TotalAmount"/>
																		</td>
																	</tr>
																</table>
															</td>
														</tr>
													</table>
													<table border="0" cellpadding="0" cellspacing="0" width="100%">
														<tr>
															<td width="80%" align="right">
																<font class="titulopeque">IMPORTE TOTAL A EJECUTAR&#160;&#160;&#160;&#160;&#160;</font>
															</td>
															<td width="20%" align="center">
																<table border="1" cellpadding="0" cellspacing="0" width="100%">
																	<tr>
																		<td align="right">
																				<xsl:value-of select="FileHeader/Batch/TotalExecutableAmount/TotalAmount"/>
																		</td>
																	</tr>
																</table>
															</td>
														</tr>
													</table>
												</xsl:if>
											</td>
										</tr>
										<tr>
											<td>&#160;</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr id="emisor">
								 <td width="100%">
									<table border="0" cellpadding="0" cellspacing="0" width="100%">
										<tr>
											 <td width="100%">
												<table border="0" cellpadding="0" cellspacing="0" width="100%">
													<tr>
														<td colspan="3">
															<hr/>
														</td>
													</tr>
													<tr>
														<td colspan="2">
															<font class="titulo2">
																DATOS EMISOR
															</font>
														</td>
														<td align="right">

														</td>
													</tr>
													<tr>
														<td colspan="3">&#160;</td>
													</tr>
													<xsl:if test='Parties/SellerParty/LegalEntity!=""' >
														<tr>
															<td width="50%" colspan="2">
																<font class="titulopeque">
																	RAZÓN SOCIAL:
																</font>
																&#160;&#160;&#160;
																<xsl:value-of select="Parties/SellerParty/LegalEntity/CorporateName"/>
															</td>
															<td width="50%">
																<font class="titulopeque">
																	NIF/CIF:
																</font>
																&#160;&#160;&#160;
																<xsl:value-of select="Parties/SellerParty/TaxIdentification/TaxIdentificationNumber"/>
															</td>
														</tr>
													</xsl:if>
													<xsl:if test='Parties/SellerParty/Individual!=""' >
														<tr>
															<td width="50%" colspan="2">
																<font class="titulopeque">
																	NOMBRE Y APELLIDOS:
																</font>
																&#160;&#160;&#160;
																<xsl:value-of select="Parties/SellerParty/Individual/Name"/>&#160;
																<xsl:value-of select="Parties/SellerParty/Individual/FirstSurname"/>&#160;
																<xsl:value-of select="Parties/SellerParty/Individual/SecondSurname"/>&#160;
															</td>
															<td width="50%">
																<font class="titulopeque">
																	NIF/CIF:
																</font>
																&#160;&#160;&#160;
																<xsl:value-of select="Parties/SellerParty/TaxIdentification/TaxIdentificationNumber"/>
															</td>
														</tr>
													</xsl:if>
												</table>
											</td>
										</tr>
										<tr id="datosEmisor" style="">
											<td width="100%">
												<table border="0" cellpadding="0" cellspacing="0" width="100%">
													<tr>
														<td width="50%" colspan="2">
															<font class="titulopeque">
																TIPO PERSONA:
															</font>
															&#160;&#160;&#160;
															<script>
																document.write(descTipoPersona('<xsl:value-of select="Parties/SellerParty/TaxIdentification/PersonTypeCode"/>'));
															</script>
														</td>
														<td width="50%">
															<font class="titulopeque">
																TIPO RESIDENCIA:
															</font>
															&#160;&#160;&#160;
															<script>
																document.write(descTipoResidencia('<xsl:value-of select="Parties/SellerParty/TaxIdentification/ResidenceTypeCode"/>'));
															</script>
														</td>
													</tr>
													<xsl:if test='Parties/SellerParty/PartyIdentification!=""' >
														<tr>
															<td width="50%" colspan="2">
															<font class="titulopeque">
																IDENTIFICACIÓN:
															</font>
															&#160;&#160;&#160;
																<xsl:value-of select="Parties/SellerParty/PartyIdentification"/>
															</td>
														</tr>
													</xsl:if>
													<xsl:if test='Parties/SellerParty/LegalEntity!=""' >
														<tr>
															<td valign="top" width="10%">
																<font class="titulopeque">
																	DIRECCIÓN:
																</font>
															</td>
															<td valign="top" width="40%">
																<xsl:if test='Parties/SellerParty/LegalEntity/AddressInSpain!=""' >
																	<xsl:value-of select="Parties/SellerParty/LegalEntity/AddressInSpain/Address"/><br/>
																	<xsl:value-of select="Parties/SellerParty/LegalEntity/AddressInSpain/PostCode"/>&#160;&#160;
																	<xsl:value-of select="Parties/SellerParty/LegalEntity/AddressInSpain/Town"/><br/>
																	<xsl:value-of select="Parties/SellerParty/LegalEntity/AddressInSpain/Province"/><br/>
																	<xsl:value-of select="Parties/SellerParty/LegalEntity/AddressInSpain/CountryCode"/>
																</xsl:if>
																<xsl:if test='Parties/SellerParty/LegalEntity/OverseasAddress!=""' >
																	<xsl:value-of select="Parties/SellerParty/LegalEntity/OverseasAddress/Address"/><br/>
																	<xsl:value-of select="Parties/SellerParty/LegalEntity/OverseasAddress/PostCodeAndTown"/><br/>
																	<xsl:value-of select="Parties/SellerParty/LegalEntity/OverseasAddress/Province"/><br/>
																	<xsl:value-of select="Parties/SellerParty/LegalEntity/OverseasAddress/CountryCode"/>
																</xsl:if>
															</td>
															<xsl:if test='Parties/SellerParty/LegalEntity/TradeName!=""' >
																<td valign="top" width="50%">
																	<font class="titulopeque">
																		NOMBRE COMERCIAL:
																	</font>
																	&#160;&#160;&#160;
																	<xsl:value-of select="Parties/SellerParty/LegalEntity/TradeName"/>
																</td>
															</xsl:if>
														</tr>
														<xsl:if test='Parties/SellerParty/LegalEntity/RegistrationData!=""' >
															<tr>
																<td width="30%" colspan="3">
																<font class="titulopeque">
																	DATOS REGISTRALES:
																</font>
																</td>
															</tr>
															<tr>
																<td colspan="3">
																	<table border="0" cellpadding="0" cellspacing="0" width="100%">
																		<tr>
																			<td width="25%">
																				<font class="titulopeque">Libro:</font>&#160;&#160;&#160;
																				<xsl:value-of select="Parties/SellerParty/LegalEntity/RegistrationData/Book"/>
																			</td>
																			<td width="25%">
																				<font class="titulopeque">Registro mercantil:</font>&#160;&#160;&#160;
																				<xsl:value-of select="Parties/SellerParty/LegalEntity/RegistrationData/RegisterOfCompaniesLocation"/>
																			</td>
																			<td width="25%">
																				<font class="titulopeque">Hoja:</font>&#160;&#160;&#160;
																				<xsl:value-of select="Parties/SellerParty/LegalEntity/RegistrationData/Sheet"/>
																			</td>
																			<td width="25%">
																				<font class="titulopeque">Folio:</font>&#160;&#160;&#160;
																				<xsl:value-of select="Parties/SellerParty/LegalEntity/RegistrationData/Folio"/>
																			</td>
																		</tr>
																		<tr>
																			<td width="25%">
																				<font class="titulopeque">Sección:</font>&#160;&#160;&#160;
																				<xsl:value-of select="Parties/SellerParty/LegalEntity/RegistrationData/Section"/>
																			</td>
																			<td width="25%">
																				<font class="titulopeque">Tomo:</font>&#160;&#160;&#160;
																				<xsl:value-of select="Parties/SellerParty/LegalEntity/RegistrationData/Volume"/>
																			</td>
																			<td width="25%">
																				<font class="titulopeque">Otros:</font>&#160;&#160;&#160;
																				<xsl:value-of select="Parties/SellerParty/LegalEntity/RegistrationData/AdditionalRegistrationData"/>
																			</td>
																		</tr>
																	</table>
																</td>
															</tr>
														</xsl:if>
														<xsl:if test='Parties/SellerParty/LegalEntity/ContactDetails!=""' >
															<tr>
																<td width="30%" colspan="3">
																<font class="titulopeque">
																	DATOS DE CONTACTO:
																</font>
																</td>
															</tr>
															<tr>
																<td colspan="3">
																	<table border="0" cellpadding="0" cellspacing="0" width="100%">
																		<tr>
																			<td width="25%">
																				<font class="titulopeque">Teléfono:</font>&#160;&#160;&#160;
																				<xsl:value-of select="Parties/SellerParty/LegalEntity/ContactDetails/Telephone"/>
																			</td>
																			<td width="25%">
																				<font class="titulopeque">Fax:</font>&#160;&#160;&#160;
																				<xsl:value-of select="Parties/SellerParty/LegalEntity/ContactDetails/TeleFax"/>
																			</td>
																			<td width="25%">
																				<font class="titulopeque">Web:</font>&#160;&#160;&#160;
																				<xsl:value-of select="Parties/SellerParty/LegalEntity/ContactDetails/WebAddress"/>
																			</td>
																			<td width="25%">
																				<font class="titulopeque">Email:</font>&#160;&#160;&#160;
																				<xsl:value-of select="Parties/SellerParty/LegalEntity/ContactDetails/ElectronicMail"/>
																			</td>
																		</tr>
																		<tr>
																			<td width="25%">
																				<font class="titulopeque">Personas contacto:</font>&#160;&#160;&#160;
																				<xsl:value-of select="Parties/SellerParty/LegalEntity/ContactDetails/ContactPersons"/>
																			</td>
																			<td width="25%">
																				<font class="titulopeque">CnoCnae:</font>&#160;&#160;&#160;
																				<xsl:value-of select="Parties/SellerParty/LegalEntity/ContactDetails/CnoCnae"/>
																			</td>
																			<td width="25%">
																				<font class="titulopeque">Código INE:</font>&#160;&#160;&#160;
																				<xsl:value-of select="Parties/SellerParty/LegalEntity/ContactDetails/INETownCode"/>
																			</td>
																			<td width="25%">
																				<font class="titulopeque">Otros:</font>&#160;&#160;&#160;
																				<xsl:value-of select="Parties/SellerParty/LegalEntity/ContactDetails/AdditionalContactDetails"/>
																			</td>
																		</tr>
																	</table>
																</td>
															</tr>
														</xsl:if>
													</xsl:if>
													<xsl:if test='Parties/SellerParty/Individual!=""' >
														<tr>
															<td valign="top" width="10%">
																<font class="titulopeque">
																	DIRECCIÓN:
																</font>
															</td>
															<td valign="top" width="40%">
																<xsl:if test='Parties/SellerParty/Individual/AddressInSpain!=""' >
																	<xsl:value-of select="Parties/SellerParty/Individual/AddressInSpain/Address"/><br/>
																	<xsl:value-of select="Parties/SellerParty/Individual/AddressInSpain/PostCode"/>&#160;&#160;
																	<xsl:value-of select="Parties/SellerParty/Individual/AddressInSpain/Town"/><br/>
																	<xsl:value-of select="Parties/SellerParty/Individual/AddressInSpain/Province"/><br/>
																	<xsl:value-of select="Parties/SellerParty/Individual/AddressInSpain/CountryCode"/>
																</xsl:if>
																<xsl:if test='Parties/SellerParty/Individual/OverseasAddress!=""' >
																	<xsl:value-of select="Parties/SellerParty/Individual/OverseasAddress/Address"/><br/>
																	<xsl:value-of select="Parties/SellerParty/Individual/OverseasAddress/PostCodeAndTown"/><br/>
																	<xsl:value-of select="Parties/SellerParty/Individual/OverseasAddress/Province"/><br/>
																	<xsl:value-of select="Parties/SellerParty/Individual/OverseasAddress/CountryCode"/>
																</xsl:if>
															</td>
														</tr>
														<xsl:if test='Parties/SellerParty/Individual/ContactDetails!=""' >
															<tr>
																<td width="30%" colspan="3">
																<font class="titulopeque">
																	DATOS DE CONTACTO:
																</font>
																</td>
															</tr>
															<tr>
																<td colspan="3">
																	<table border="0" cellpadding="0" cellspacing="0" width="100%">
																		<tr>
																			<td width="25%">
																				<font class="titulopeque">Teléfono:</font>&#160;&#160;&#160;
																				<xsl:value-of select="Parties/SellerParty/Individual/ContactDetails/Telephone"/>
																			</td>
																			<td width="25%">
																				<font class="titulopeque">Fax:</font>&#160;&#160;&#160;
																				<xsl:value-of select="Parties/SellerParty/Individual/ContactDetails/TeleFax"/>
																			</td>
																			<td width="25%">
																				<font class="titulopeque">Web:</font>&#160;&#160;&#160;
																				<xsl:value-of select="Parties/SellerParty/Individual/ContactDetails/WebAddress"/>
																			</td>
																			<td width="25%">
																				<font class="titulopeque">Email:</font>&#160;&#160;&#160;
																				<xsl:value-of select="Parties/SellerParty/Individual/ContactDetails/ElectronicMail"/>
																			</td>
																		</tr>
																		<tr>
																			<td width="25%">
																				<font class="titulopeque">Personas contacto:</font>&#160;&#160;&#160;
																				<xsl:value-of select="Parties/SellerParty/Individual/ContactDetails/ContactPersons"/>
																			</td>
																			<td width="25%">
																				<font class="titulopeque">CnoCnae:</font>&#160;&#160;&#160;
																				<xsl:value-of select="Parties/SellerParty/Individual/ContactDetails/CnoCnae"/>
																			</td>
																			<td width="25%">
																				<font class="titulopeque">Código INE:</font>&#160;&#160;&#160;
																				<xsl:value-of select="Parties/SellerParty/Individual/ContactDetails/INETownCode"/>
																			</td>
																			<td width="25%">
																				<font class="titulopeque">Otros:</font>&#160;&#160;&#160;
																				<xsl:value-of select="Parties/SellerParty/Individual/ContactDetails/AdditionalContactDetails"/>
																			</td>
																		</tr>
																	</table>
																</td>
															</tr>
															</xsl:if>
													</xsl:if>
													<xsl:if test='Parties/SellerParty/AdministrativeCentres!=""' >
														<tr>
															<td colspan="3">
																	<font class="titulopeque">CENTROS</font>
																	<table border="1" cellpadding="0" cellspacing="0" width="100%">
																		<tr>
																			<td width="7%" valign="top" align="center">
																				<font class="titulopeque">Número</font>
																			</td>
																			<td width="7%" valign="top" align="center">
																				<font class="titulopeque">Tipo rol</font>
																			</td>
																			<td width="14%" valign="top" align="center">
																				<font class="titulopeque">Nombre</font>
																			</td>
																			<td width="15%" valign="top" align="center">
																				<font class="titulopeque">Dirección</font>
																			</td>
																			<td width="25%" valign="top" align="center">
																				<font class="titulopeque">Datos de contacto</font>
																			</td>
																			<td width="9%" valign="top" align="center">
																				<font class="titulopeque">GLN Físico</font>
																			</td>
																			<td width="9%" valign="top" align="center">
																				<font class="titulopeque">Pto op. lógico</font>
																			</td>
																			<td width="14%" valign="top" align="center">
																				<font class="titulopeque">Descripción</font>
																			</td>
																		</tr>
																		<xsl:for-each select="Parties/SellerParty/AdministrativeCentres/AdministrativeCentre">
																		<tr>
																			<td valign="top">
																				<xsl:choose>
																					<xsl:when test='CentreCode!=""' >
																						<xsl:apply-templates select="CentreCode"/>
																					</xsl:when>
																					<xsl:otherwise>
																						&#160;
																					</xsl:otherwise>
																				</xsl:choose>
																			</td>
																			<td valign="top">
																				<xsl:choose>
																					<xsl:when test='RoleTypeCode!=""' >
																						<script>
																							document.write(descTipoRol('<xsl:value-of select="RoleTypeCode"/>'));
																						</script>
																					</xsl:when>
																					<xsl:otherwise>
																						&#160;
																					</xsl:otherwise>
																				</xsl:choose>
																			</td>
																			<td valign="top">
																				<xsl:choose>
																					<xsl:when test='(Name!="") or (FirstSurname!="") or (SecondSurname!="")' >
																						<xsl:value-of select="Name"/>&#160;
																						<xsl:value-of select="FirstSurname"/>&#160;
																						<xsl:value-of select="SecondSurname"/>&#160;
																					</xsl:when>
																					<xsl:otherwise>
																						&#160;
																					</xsl:otherwise>
																				</xsl:choose>
																			</td>
																			<td valign="top">
																				<xsl:choose>
																					<xsl:when test='(AddressInSpain!="") or (OverseasAddress!="")' >
																						<xsl:if test='AddressInSpain!=""' >
																							<xsl:value-of select="AddressInSpain/Address"/><br/>
																							<xsl:value-of select="AddressInSpain/PostCode"/>&#160;&#160;&#160;
																							<xsl:value-of select="AddressInSpain/Town"/><br/>
																							<xsl:value-of select="AddressInSpain/Province"/><br/>
																							<xsl:value-of select="AddressInSpain/CountryCode"/>
																						</xsl:if>
																						<xsl:if test='OverseasAddress!=""' >
																							<xsl:value-of select="OverseasAddress/Address"/><br/>
																							<xsl:value-of select="OverseasAddress/PostCodeAndTown"/><br/>
																							<xsl:value-of select="OverseasAddress/Province"/><br/>
																							<xsl:value-of select="OverseasAddress/CountryCode"/>
																						</xsl:if>
																					</xsl:when>
																					<xsl:otherwise>
																						&#160;
																					</xsl:otherwise>
																				</xsl:choose>
																			</td>
																			<td valign="top">
																				<xsl:choose>
																					<xsl:when test='ContactDetails!=""' >
																						<table border="0" cellpadding="0" cellspacing="0" width="100%">
																							<tr>
																								<td width="50%">
																									<font class="titulopeque">Teléfono:</font>&#160;
																									<xsl:value-of select="ContactDetails/Telephone"/>
																								</td>
																								<td width="50%">
																									<font class="titulopeque">Fax:</font>&#160;
																									<xsl:value-of select="ContactDetails/TeleFax"/>
																								</td>
																							</tr>
																							<tr>
																								<td width="50%">
																									<font class="titulopeque">Web:</font>&#160;
																									<xsl:value-of select="ContactDetails/WebAddress"/>
																								</td>
																								<td width="50%">
																									<font class="titulopeque">Email:</font>&#160;
																									<xsl:value-of select="ContactDetails/ElectronicMail"/>
																								</td>
																							</tr>
																							<tr>
																								<td width="50%">
																									<font class="titulopeque">Contacto:</font>&#160;
																									<xsl:value-of select="ContactDetails/ContactPersons"/>
																								</td>
																								<td width="50%">
																									<font class="titulopeque">CnoCnae:</font>&#160;
																									<xsl:value-of select="ContactDetails/CnoCnae"/>
																								</td>
																							</tr>
																							<tr>
																								<td width="50%">
																									<font class="titulopeque">Cód. INE:</font>&#160;
																									<xsl:value-of select="ContactDetails/INETownCode"/>
																								</td>
																								<td width="50%">
																									<font class="titulopeque">Otros:</font>&#160;
																									<xsl:value-of select="ContactDetails/AdditionalContactDetails"/>
																								</td>
																							</tr>
																						</table>
																					</xsl:when>
																					<xsl:otherwise>
																						&#160;
																					</xsl:otherwise>
																				</xsl:choose>
																			</td>
																			<td valign="top">
																				<xsl:choose>
																					<xsl:when test='PhysicalGLN!=""' >
																						<xsl:apply-templates select="PhysicalGLN"/>
																					</xsl:when>
																					<xsl:otherwise>
																						&#160;
																					</xsl:otherwise>
																				</xsl:choose>
																			</td>
																			<td valign="top">
																				<xsl:choose>
																					<xsl:when test='LogicalOperationalPoint!=""' >
																						<xsl:apply-templates select="LogicalOperationalPoint"/>
																					</xsl:when>
																					<xsl:otherwise>
																						&#160;
																					</xsl:otherwise>
																				</xsl:choose>
																			</td>
																			<td valign="top">
																				<xsl:choose>
																					<xsl:when test='CentreDescription!=""' >
																						<xsl:apply-templates select="CentreDescription"/>
																					</xsl:when>
																					<xsl:otherwise>
																						&#160;
																					</xsl:otherwise>
																				</xsl:choose>
																			</td>
																		</tr>
																		</xsl:for-each>
																	</table>
															</td>
														</tr>
													</xsl:if>
												</table>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr id="receptor">
								 <td width="100%">
									<table border="0" cellpadding="0" cellspacing="0" width="100%">
										<tr>
											 <td width="100%">
												<table border="0" cellpadding="0" cellspacing="0" width="100%">
													<tr>
														<td colspan="3">&#160;</td>
													</tr>
													<tr>
														<td colspan="3">
															<hr/>
														</td>
													</tr>
													<tr>
														<td colspan="2">
															<font class="titulo2">
																DATOS RECEPTOR
															</font>
														</td>
														<td align="right">

														</td>
													</tr>
													<tr>
														<td colspan="3">&#160;</td>
													</tr>
													<xsl:if test='Parties/BuyerParty/LegalEntity!=""' >
														<tr>
															<td width="50%" colspan="2">
																<font class="titulopeque">
																	RAZÓN SOCIAL:
																</font>
																&#160;&#160;&#160;
																<xsl:value-of select="Parties/BuyerParty/LegalEntity/CorporateName"/>
															</td>
															<td  width="50%">
																<font class="titulopeque">
																	NIF/CIF:
																</font>
																&#160;&#160;&#160;
																<xsl:value-of select="Parties/BuyerParty/TaxIdentification/TaxIdentificationNumber"/>
															</td>
														</tr>
													</xsl:if>
													<xsl:if test='Parties/BuyerParty/Individual!=""' >
														<tr>
															<td width="50%" colspan="2">
																<font class="titulopeque">
																	NOMBRE Y APELLIDOS:
																</font>
																&#160;&#160;&#160;
																<xsl:value-of select="Parties/BuyerParty/Individual/Name"/>&#160;
																<xsl:value-of select="Parties/BuyerParty/Individual/FirstSurname"/>&#160;
																<xsl:value-of select="Parties/BuyerParty/Individual/SecondSurname"/>&#160;
															</td>
															<td width="50%">
																<font class="titulopeque">
																	NIF/CIF:
																</font>
																&#160;&#160;&#160;
																<xsl:value-of select="Parties/BuyerParty/TaxIdentification/TaxIdentificationNumber"/>
															</td>
														</tr>
													</xsl:if>
												</table>
											</td>
										</tr>
										<tr id="datosReceptor" style="">
											<td width="100%">
												<table border="0" cellpadding="0" cellspacing="0" width="100%">
													<tr>
														<td width="50%" colspan="2">
															<font class="titulopeque">
																TIPO PERSONA:
															</font>
															&#160;&#160;&#160;
															<script>
																document.write(descTipoPersona('<xsl:value-of select="Parties/BuyerParty/TaxIdentification/PersonTypeCode"/>'));
															</script>
														</td>
														<td width="50%">
															<font class="titulopeque">
																TIPO RESIDENCIA:
															</font>
															&#160;&#160;&#160;
															<script>
																document.write(descTipoResidencia('<xsl:value-of select="Parties/BuyerParty/TaxIdentification/ResidenceTypeCode"/>'));
															</script>
														</td>
													</tr>
													<xsl:if test='Parties/BuyerParty/PartyIdentification!=""' >
														<tr>
															<td width="50%" colspan="2">
															<font class="titulopeque">
																IDENTIFICACIÓN:
															</font>
															&#160;&#160;&#160;
																<xsl:value-of select="Parties/BuyerParty/PartyIdentification"/>
															</td>
														</tr>
													</xsl:if>
													<xsl:if test='Parties/BuyerParty/LegalEntity!=""' >
														<tr>
															<td valign="top"  width="10%">
															<font class="titulopeque">
																DIRECCIÓN:
															</font>
															</td>
															<td  width="40%">
																<xsl:if test='Parties/BuyerParty/LegalEntity/AddressInSpain!=""' >
																	<xsl:value-of select="Parties/BuyerParty/LegalEntity/AddressInSpain/Address"/><br/>
																	<xsl:value-of select="Parties/BuyerParty/LegalEntity/AddressInSpain/PostCode"/>&#160;&#160;&#160;
																	<xsl:value-of select="Parties/BuyerParty/LegalEntity/AddressInSpain/Town"/><br/>
																	<xsl:value-of select="Parties/BuyerParty/LegalEntity/AddressInSpain/Province"/><br/>
																	<xsl:value-of select="Parties/BuyerParty/LegalEntity/AddressInSpain/CountryCode"/>
																</xsl:if>
																<xsl:if test='Parties/BuyerParty/LegalEntity/OverseasAddress!=""' >
																	<xsl:value-of select="Parties/BuyerParty/LegalEntity/OverseasAddress/Address"/><br/>
																	<xsl:value-of select="Parties/BuyerParty/LegalEntity/OverseasAddress/PostCodeAndTown"/><br/>
																	<xsl:value-of select="Parties/BuyerParty/LegalEntity/OverseasAddress/Province"/><br/>
																	<xsl:value-of select="Parties/BuyerParty/LegalEntity/OverseasAddress/CountryCode"/>
																</xsl:if>
															</td>
															<xsl:if test='Parties/BuyerParty/LegalEntity/TradeName!=""' >
																<td valign="top" width="50%">
																	<font class="titulopeque">
																		NOMBRE COMERCIAL:
																	</font>
																	&#160;&#160;&#160;
																	<xsl:value-of select="Parties/BuyerParty/LegalEntity/TradeName"/>
																</td>
														</xsl:if>
														</tr>
														<xsl:if test='Parties/BuyerParty/LegalEntity/RegistrationData!=""' >
															<tr>
																<td width="30%" colspan="3">
																<font class="titulopeque">
																	DATOS REGISTRALES:
																</font>
																</td>
															</tr>
															<tr>
																<td colspan="3">
																	<table border="0" cellpadding="0" cellspacing="0" width="100%">
																		<tr>
																			<td width="25%">
																				<font class="titulopeque">Libro:</font>&#160;&#160;&#160;
																				<xsl:value-of select="Parties/BuyerParty/LegalEntity/RegistrationData/Book"/>
																			</td>
																			<td width="25%">
																				<font class="titulopeque">Registro mercantil:</font>&#160;&#160;&#160;
																				<xsl:value-of select="Parties/BuyerParty/LegalEntity/RegistrationData/RegisterOfCompaniesLocation"/>
																			</td>
																			<td width="25%">
																				<font class="titulopeque">Hoja:</font>&#160;&#160;&#160;
																				<xsl:value-of select="Parties/BuyerParty/LegalEntity/RegistrationData/Sheet"/>
																			</td>
																			<td width="25%">
																				<font class="titulopeque">Folio:</font>&#160;&#160;&#160;
																				<xsl:value-of select="Parties/BuyerParty/LegalEntity/RegistrationData/Folio"/>
																			</td>
																		</tr>
																		<tr>
																			<td width="25%">
																				<font class="titulopeque">Sección:</font>&#160;&#160;&#160;
																				<xsl:value-of select="Parties/BuyerParty/LegalEntity/RegistrationData/Section"/>
																			</td>
																			<td width="25%">
																				<font class="titulopeque">Tomo:</font>&#160;&#160;&#160;
																				<xsl:value-of select="Parties/BuyerParty/LegalEntity/RegistrationData/Volume"/>
																			</td>
																			<td width="25%">
																				<font class="titulopeque">Otros:</font>&#160;&#160;&#160;
																				<xsl:value-of select="Parties/BuyerParty/LegalEntity/RegistrationData/AdditionalRegistrationData"/>
																			</td>
																		</tr>
																	</table>
																</td>
															</tr>
														</xsl:if>
														<xsl:if test='Parties/BuyerParty/LegalEntity/ContactDetails!=""' >
															<tr>
																<td width="30%" colspan="3">
																<font class="titulopeque">
																	DATOS DE CONTACTO:
																</font>
																</td>
															</tr>
															<tr>
																<td colspan="3">
																	<table border="0" cellpadding="0" cellspacing="0" width="100%">
																		<tr>
																			<td width="25%">
																				<font class="titulopeque">Teléfono:</font>&#160;&#160;&#160;
																				<xsl:value-of select="Parties/BuyerParty/LegalEntity/ContactDetails/Telephone"/>
																			</td>
																			<td width="25%">
																				<font class="titulopeque">Fax:</font>&#160;&#160;&#160;
																				<xsl:value-of select="Parties/BuyerParty/LegalEntity/ContactDetails/TeleFax"/>
																			</td>
																			<td width="25%">
																				<font class="titulopeque">Web:</font>&#160;&#160;&#160;
																				<xsl:value-of select="Parties/BuyerParty/LegalEntity/ContactDetails/WebAddress"/>
																			</td>
																			<td width="25%">
																				<font class="titulopeque">Email:</font>&#160;&#160;&#160;
																				<xsl:value-of select="Parties/BuyerParty/LegalEntity/ContactDetails/ElectronicMail"/>
																			</td>
																		</tr>
																		<tr>
																			<td width="25%">
																				<font class="titulopeque">Personas contacto:</font>&#160;&#160;&#160;
																				<xsl:value-of select="Parties/BuyerParty/LegalEntity/ContactDetails/ContactPersons"/>
																			</td>
																			<td width="25%">
																				<font class="titulopeque">CnoCnae:</font>&#160;&#160;&#160;
																				<xsl:value-of select="Parties/BuyerParty/LegalEntity/ContactDetails/CnoCnae"/>
																			</td>
																			<td width="25%">
																				<font class="titulopeque">Código INE:</font>&#160;&#160;&#160;
																				<xsl:value-of select="Parties/BuyerParty/LegalEntity/ContactDetails/INETownCode"/>
																			</td>
																			<td width="25%">
																				<font class="titulopeque">Otros:</font>&#160;&#160;&#160;
																				<xsl:value-of select="Parties/BuyerParty/LegalEntity/ContactDetails/AdditionalContactDetails"/>
																			</td>
																		</tr>
																	</table>
																</td>
															</tr>
														</xsl:if>
													</xsl:if>
													<xsl:if test='Parties/BuyerParty/Individual!=""' >
														<tr>
															<td valign="top" width="10%">
															<font class="titulopeque">
																DIRECCIÓN:
															</font>
															</td>
															<td valign="top" width="40%">
																<xsl:if test='Parties/BuyerParty/Individual/AddressInSpain!=""' >
																	<xsl:value-of select="Parties/BuyerParty/Individual/AddressInSpain/Address"/><br/>
																	<xsl:value-of select="Parties/BuyerParty/Individual/AddressInSpain/PostCode"/>&#160;&#160;&#160;
																	<xsl:value-of select="Parties/BuyerParty/Individual/AddressInSpain/Town"/><br/>
																	<xsl:value-of select="Parties/BuyerParty/Individual/AddressInSpain/Province"/><br/>
																	<xsl:value-of select="Parties/BuyerParty/Individual/AddressInSpain/CountryCode"/>
																</xsl:if>
																<xsl:if test='Parties/BuyerParty/Individual/OverseasAddress!=""' >
																	<xsl:value-of select="Parties/BuyerParty/Individual/OverseasAddress/Address"/><br/>
																	<xsl:value-of select="Parties/BuyerParty/Individual/OverseasAddress/PostCodeAndTown"/><br/>
																	<xsl:value-of select="Parties/BuyerParty/Individual/OverseasAddress/Province"/><br/>
																	<xsl:value-of select="Parties/BuyerParty/Individual/OverseasAddress/CountryCode"/>
																</xsl:if>
															</td>
														</tr>
														<xsl:if test='Parties/BuyerParty/Individual/ContactDetails!=""' >
															<tr>
																<td width="30%" colspan="3">
																<font class="titulopeque">
																	DATOS DE CONTACTO:
																</font>
																</td>
															</tr>
															<tr>
																<td colspan="3">
																	<table border="0" cellpadding="0" cellspacing="0" width="100%">
																		<tr>
																			<td width="25%">
																				<font class="titulopeque">Teléfono:</font>&#160;&#160;&#160;
																				<xsl:value-of select="Parties/BuyerParty/Individual/ContactDetails/Telephone"/>
																			</td>
																			<td width="25%">
																				<font class="titulopeque">Fax:</font>&#160;&#160;&#160;
																				<xsl:value-of select="Parties/BuyerParty/Individual/ContactDetails/TeleFax"/>
																			</td>
																			<td width="25%">
																				<font class="titulopeque">Web:</font>&#160;&#160;&#160;
																				<xsl:value-of select="Parties/BuyerParty/Individual/ContactDetails/WebAddress"/>
																			</td>
																			<td width="25%">
																				<font class="titulopeque">Email:</font>&#160;&#160;&#160;
																				<xsl:value-of select="Parties/BuyerParty/Individual/ContactDetails/ElectronicMail"/>
																			</td>
																		</tr>
																		<tr>
																			<td width="25%">
																				<font class="titulopeque">Personas contacto:</font>&#160;&#160;&#160;
																				<xsl:value-of select="Parties/BuyerParty/Individual/ContactDetails/ContactPersons"/>
																			</td>
																			<td width="25%">
																				<font class="titulopeque">CnoCnae:</font>&#160;&#160;&#160;
																				<xsl:value-of select="Parties/BuyerParty/Individual/ContactDetails/CnoCnae"/>
																			</td>
																			<td width="25%">
																				<font class="titulopeque">Código INE:</font>&#160;&#160;&#160;
																				<xsl:value-of select="Parties/BuyerParty/Individual/ContactDetails/INETownCode"/>
																			</td>
																			<td width="25%">
																				<font class="titulopeque">Otros:</font>&#160;&#160;&#160;
																				<xsl:value-of select="Parties/BuyerParty/Individual/ContactDetails/AdditionalContactDetails"/>
																			</td>
																		</tr>
																	</table>
																</td>
															</tr>
															</xsl:if>
													</xsl:if>
													<xsl:if test='Parties/BuyerParty/AdministrativeCentres!=""' >
														<tr>
															<td colspan="3">
																	<font class="titulopeque">CENTROS</font>
																	<table border="1" cellpadding="0" cellspacing="0" width="100%">
																		<tr>
																			<td width="7%" valign="top" align="center">
																				<font class="titulopeque">Número</font>
																			</td>
																			<td width="7%" valign="top" align="center">
																				<font class="titulopeque">Tipo rol</font>
																			</td>
																			<td width="14%" valign="top" align="center">
																				<font class="titulopeque">Nombre</font>
																			</td>
																			<td width="15%" valign="top" align="center">
																				<font class="titulopeque">Dirección</font>
																			</td>
																			<td width="25%" valign="top" align="center">
																				<font class="titulopeque">Datos de contacto</font>
																			</td>
																			<td width="9%" valign="top" align="center">
																				<font class="titulopeque">GLN Físico</font>
																			</td>
																			<td width="9%" valign="top" align="center">
																				<font class="titulopeque">Pto op. lógico</font>
																			</td>
																			<td width="14%" valign="top" align="center">
																				<font class="titulopeque">Descripción</font>
																			</td>
																		</tr>
																		<xsl:for-each select="Parties/BuyerParty/AdministrativeCentres/AdministrativeCentre">
																		<tr>
																			<td valign="top">
																				<xsl:choose>
																					<xsl:when test='CentreCode!=""' >
																						<xsl:apply-templates select="CentreCode"/>
																					</xsl:when>
																					<xsl:otherwise>
																						&#160;
																					</xsl:otherwise>
																				</xsl:choose>
																			</td>
																			<td valign="top">
																				<xsl:choose>
																					<xsl:when test='RoleTypeCode!=""' >
																						<script>
																							document.write(descTipoRol('<xsl:value-of select="RoleTypeCode"/>'));
																						</script>
																					</xsl:when>
																					<xsl:otherwise>
																						&#160;
																					</xsl:otherwise>
																				</xsl:choose>
																			</td>
																			<td valign="top">
																				<xsl:choose>
																					<xsl:when test='(Name!="") or (FirstSurname!="") or (SecondSurname!="")' >
																						<xsl:value-of select="Name"/>&#160;
																						<xsl:value-of select="FirstSurname"/>&#160;
																						<xsl:value-of select="SecondSurname"/>&#160;
																					</xsl:when>
																					<xsl:otherwise>
																						&#160;
																					</xsl:otherwise>
																				</xsl:choose>
																			</td>
																			<td valign="top">
																				<xsl:choose>
																					<xsl:when test='(AddressInSpain!="") or (OverseasAddress!="")' >
																						<xsl:if test='AddressInSpain!=""' >
																							<xsl:value-of select="AddressInSpain/Address"/><br/>
																							<xsl:value-of select="AddressInSpain/PostCode"/>&#160;&#160;&#160;
																							<xsl:value-of select="AddressInSpain/Town"/><br/>
																							<xsl:value-of select="AddressInSpain/Province"/><br/>
																							<xsl:value-of select="AddressInSpain/CountryCode"/>
																						</xsl:if>
																						<xsl:if test='OverseasAddress!=""' >
																							<xsl:value-of select="OverseasAddress/Address"/><br/>
																							<xsl:value-of select="OverseasAddress/PostCodeAndTown"/><br/>
																							<xsl:value-of select="OverseasAddress/Province"/><br/>
																							<xsl:value-of select="OverseasAddress/CountryCode"/>
																						</xsl:if>
																					</xsl:when>
																					<xsl:otherwise>
																						&#160;
																					</xsl:otherwise>
																				</xsl:choose>
																			</td>
																			<td valign="top">
																				<xsl:choose>
																					<xsl:when test='ContactDetails!=""' >
																						<table border="0" cellpadding="0" cellspacing="0" width="100%">
																							<tr>
																								<td width="50%">
																									<font class="titulopeque">Teléfono:</font>&#160;
																									<xsl:value-of select="ContactDetails/Telephone"/>
																								</td>
																								<td width="50%">
																									<font class="titulopeque">Fax:</font>&#160;
																									<xsl:value-of select="ContactDetails/TeleFax"/>
																								</td>
																							</tr>
																							<tr>
																								<td width="50%">
																									<font class="titulopeque">Web:</font>&#160;
																									<xsl:value-of select="ContactDetails/WebAddress"/>
																								</td>
																								<td width="50%">
																									<font class="titulopeque">Email:</font>&#160;
																									<xsl:value-of select="ContactDetails/ElectronicMail"/>
																								</td>
																							</tr>
																							<tr>
																								<td width="50%">
																									<font class="titulopeque">Contacto:</font>&#160;
																									<xsl:value-of select="ContactDetails/ContactPersons"/>
																								</td>
																								<td width="50%">
																									<font class="titulopeque">CnoCnae:</font>&#160;
																									<xsl:value-of select="ContactDetails/CnoCnae"/>
																								</td>
																							</tr>
																							<tr>
																								<td width="50%">
																									<font class="titulopeque">Cód. INE:</font>&#160;
																									<xsl:value-of select="ContactDetails/INETownCode"/>
																								</td>
																								<td width="50%">
																									<font class="titulopeque">Otros:</font>&#160;
																									<xsl:value-of select="ContactDetails/AdditionalContactDetails"/>
																								</td>
																							</tr>
																						</table>
																					</xsl:when>
																					<xsl:otherwise>
																						&#160;
																					</xsl:otherwise>
																				</xsl:choose>
																			</td>
																			<td valign="top">
																				<xsl:choose>
																					<xsl:when test='PhysicalGLN!=""' >
																						<xsl:apply-templates select="PhysicalGLN"/>
																					</xsl:when>
																					<xsl:otherwise>
																						&#160;
																					</xsl:otherwise>
																				</xsl:choose>
																			</td>
																			<td valign="top">
																				<xsl:choose>
																					<xsl:when test='LogicalOperationalPoint!=""' >
																						<xsl:apply-templates select="LogicalOperationalPoint"/>
																					</xsl:when>
																					<xsl:otherwise>
																						&#160;
																					</xsl:otherwise>
																				</xsl:choose>
																			</td>
																			<td valign="top">
																				<xsl:choose>
																					<xsl:when test='CentreDescription!=""' >
																						<xsl:apply-templates select="CentreDescription"/>
																					</xsl:when>
																					<xsl:otherwise>
																						&#160;
																					</xsl:otherwise>
																				</xsl:choose>
																			</td>
																		</tr>
																		</xsl:for-each>
																	</table>
															</td>
														</tr>
													</xsl:if>
												</table>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<xsl:apply-templates select="FileHeader/ThirdParty"/>
							<xsl:apply-templates select="Invoices/Invoice"/>
							<tr  id="listadoFacturas">
								<td width="100%">
									<table border="0" cellpadding="0" cellspacing="0" width="100%">
										<tr>
											<td>&#160;</td>
										</tr>
										<tr>
											<td>
												<hr/>
											</td>
										</tr>
										<tr>
											<td>
												<font class="titulo2">LISTADO DE FACTURAS</font>
											</td>
										</tr>
										<tr>
											<td>&#160;</td>
										</tr>
										<tr>
											<td width="100%">
												<table border="1" cellpadding="0" cellspacing="0" width="100%">
													<tr>
														<td width="20%" align="center">
															<font class="titulopeque">NÚMERO</font>
														</td>
														<td width="20%" align="center">
															<font class="titulopeque">SERIE</font>
														</td>
														<td width="20%" align="center">
															<font class="titulopeque">FECHA EXPED.</font>
														</td>
														<td width="20%" align="center">
															<font class="titulopeque">IMPORTE BRUTO</font>
														</td>
														<td width="20%" align="center">
															<font class="titulopeque">TOTAL EUROS</font>
														</td>
													</tr>
													<xsl:for-each select="Invoices/Invoice">
													<tr style="cursor:hand" onclick="mostrarFactura('{InvoiceHeader/InvoiceNumber}')" onMouseOver="this.style.background='#DDEEEE'" onMouseOut="this.style.background='#FFFFFF'">
														<td>
															<xsl:value-of select="InvoiceHeader/InvoiceNumber"/>
														</td>
														<td align="center">
															<xsl:choose>
																<xsl:when test='InvoiceHeader/InvoiceSeriesCode!=""' >
																	<xsl:value-of select="InvoiceHeader/InvoiceSeriesCode"/>
																</xsl:when>
																<xsl:otherwise>
																	&#160;
																</xsl:otherwise>
															</xsl:choose>
														</td>
														<td align="center">
															<xsl:value-of select="substring(InvoiceIssueData/IssueDate,9,2)"/>-<xsl:value-of select="substring(InvoiceIssueData/IssueDate,6,2)"/>-<xsl:value-of select="substring(InvoiceIssueData/IssueDate,1,4)"/>
														</td>
														<td align="right">
															<xsl:value-of select="InvoiceTotals/TotalGrossAmount"/>
														</td>
														<td align="right">
															<xsl:value-of select="InvoiceTotals/TotalExecutableAmount"/>
														</td>
													</tr>
													</xsl:for-each>
												</table>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<xsl:apply-templates select="FileHeader/FactoringAssignmentData"/>
							<tr><td>&#160;</td></tr>
							<tr><td><hr/></td></tr>
							<tr><td>&#160;</td></tr>
							<tr><td>&#160;</td></tr>
							<tr><td>&#160;</td></tr>
						</table>
					</center>
					</div>
			</body>
	</xsl:template>
	<xsl:template match="//m:Facturae/FileHeader/ThirdParty">
		<tr id="tercero">
			 <td width="100%">
				<table border="0" cellpadding="0" cellspacing="0" width="100%">
					<tr>
						 <td width="100%">
							<table border="0" cellpadding="0" cellspacing="0" width="100%">
								<tr>
									<td colspan="3">&#160;</td>
								</tr>
								<tr>
									<td colspan="3">
										<hr/>
									</td>
								</tr>
								<tr>
									<td colspan="2">
										<font class="titulo2">
											DATOS TERCERO
										</font>
									</td>
									<td align="right">

									</td>
								</tr>
								<tr>
									<td colspan="3">&#160;</td>
								</tr>
								<xsl:if test='LegalEntity!=""' >
									<tr>
										<td width="50%" colspan="2">
											<font class="titulopeque">
												RAZÓN SOCIAL:
											</font>
											&#160;&#160;&#160;
											<xsl:value-of select="LegalEntity/CorporateName"/>
										</td>
										<td width="50%">
											<font class="titulopeque">
												NIF/CIF:
											</font>
											&#160;&#160;&#160;
											<xsl:value-of select="TaxIdentification/TaxIdentificationNumber"/>
										</td>
									</tr>
								</xsl:if>
								<xsl:if test='Individual!=""' >
									<tr>
										<td width="50%" colspan="2">
											<font class="titulopeque">
												NOMBRE Y APELLIDOS:
											</font>
											&#160;&#160;&#160;
											<xsl:value-of select="Individual/Name"/>&#160;
											<xsl:value-of select="Individual/FirstSurname"/>&#160;
											<xsl:value-of select="Individual/SecondSurname"/>&#160;
										</td>
										<td width="50%">
											<font class="titulopeque">
												NIF/CIF:
											</font>
											&#160;&#160;&#160;
											<xsl:value-of select="TaxIdentification/TaxIdentificationNumber"/>
										</td>
									</tr>
								</xsl:if>
							</table>
						</td>
					</tr>
					<tr id="datosTercero" style="">
						<td width="100%">
							<table border="0" cellpadding="0" cellspacing="0" width="100%">
								<tr>
									<td width="50%" colspan="2">
										<font class="titulopeque">
											TIPO PERSONA:
										</font>
										&#160;&#160;&#160;
										<script>
											document.write(descTipoPersona('<xsl:value-of select="TaxIdentification/PersonTypeCode"/>'));
										</script>
									</td>
									<td width="50%">
										<font class="titulopeque">
											TIPO RESIDENCIA:
										</font>
										&#160;&#160;&#160;
										<script>
											document.write(descTipoResidencia('<xsl:value-of select="TaxIdentification/ResidenceTypeCode"/>'));
										</script>
									</td>
								</tr>
								<xsl:if test='LegalEntity!=""' >
									<tr>
										<td valign="top"  width="10%">
											<font class="titulopeque">
												DIRECCIÓN:
											</font>
										</td>
										<td valign="top" width="40%">
											<xsl:if test='LegalEntity/AddressInSpain!=""' >
												<xsl:value-of select="LegalEntity/AddressInSpain/Address"/><br/>
												<xsl:value-of select="LegalEntity/AddressInSpain/PostCode"/>&#160;&#160;&#160;
												<xsl:value-of select="LegalEntity/AddressInSpain/Town"/><br/>
												<xsl:value-of select="LegalEntity/AddressInSpain/Province"/><br/>
												<xsl:value-of select="LegalEntity/AddressInSpain/CountryCode"/>
											</xsl:if>
											<xsl:if test='LegalEntity/OverseasAddress!=""' >
												<xsl:value-of select="LegalEntity/OverseasAddress/Address"/><br/>
												<xsl:value-of select="LegalEntity/OverseasAddress/PostCodeAndTown"/><br/>
												<xsl:value-of select="LegalEntity/OverseasAddress/Province"/><br/>
												<xsl:value-of select="LegalEntity/OverseasAddress/CountryCode"/>
											</xsl:if>
										</td>
										<xsl:if test='LegalEntity/TradeName!=""' >
											<td valign="top" width="50%">
												<font class="titulopeque">
													NOMBRE COMERCIAL:
												</font>
												&#160;&#160;&#160;
												<xsl:value-of select="LegalEntity/TradeName"/>
											</td>
										</xsl:if>
									</tr>
									<xsl:if test='LegalEntity/RegistrationData!=""' >
										<tr>
											<td width="30%" colspan="3">
											<font class="titulopeque">
												DATOS REGISTRALES:
											</font>
											</td>
										</tr>
										<tr>
											<td colspan="3">
												<table border="0" cellpadding="0" cellspacing="0" width="100%">
													<tr>
														<td width="25%">
															<font class="titulopeque">Libro:</font>&#160;&#160;&#160;
															<xsl:value-of select="LegalEntity/RegistrationData/Book"/>
														</td>
														<td width="25%">
															<font class="titulopeque">Registro mercantil:</font>&#160;&#160;&#160;
															<xsl:value-of select="LegalEntity/RegistrationData/RegisterOfCompaniesLocation"/>
														</td>
														<td width="25%">
															<font class="titulopeque">Hoja:</font>&#160;&#160;&#160;
															<xsl:value-of select="LegalEntity/RegistrationData/Sheet"/>
														</td>
														<td width="25%">
															<font class="titulopeque">Folio:</font>&#160;&#160;&#160;
															<xsl:value-of select="LegalEntity/RegistrationData/Folio"/>
														</td>
													</tr>
													<tr>
														<td width="25%">
															<font class="titulopeque">Sección:</font>&#160;&#160;&#160;
															<xsl:value-of select="LegalEntity/RegistrationData/Section"/>
														</td>
														<td width="25%">
															<font class="titulopeque">Tomo:</font>&#160;&#160;&#160;
															<xsl:value-of select="LegalEntity/RegistrationData/Volume"/>
														</td>
														<td width="25%">
															<font class="titulopeque">Otros:</font>&#160;&#160;&#160;
															<xsl:value-of select="LegalEntity/RegistrationData/AdditionalRegistrationData"/>
														</td>
													</tr>
												</table>
											</td>
										</tr>
									</xsl:if>
									<xsl:if test='LegalEntity/ContactDetails!=""' >
										<tr>
											<td width="30%" colspan="3">
											<font class="titulopeque">
												DATOS DE CONTACTO:
											</font>
											</td>
										</tr>
										<tr>
											<td colspan="3">
												<table border="0" cellpadding="0" cellspacing="0" width="100%">
													<tr>
														<td width="25%">
															<font class="titulopeque">Teléfono:</font>&#160;&#160;&#160;
															<xsl:value-of select="LegalEntity/ContactDetails/Telephone"/>
														</td>
														<td width="25%">
															<font class="titulopeque">Fax:</font>&#160;&#160;&#160;
															<xsl:value-of select="LegalEntity/ContactDetails/TeleFax"/>
														</td>
														<td width="25%">
															<font class="titulopeque">Web:</font>&#160;&#160;&#160;
															<xsl:value-of select="LegalEntity/ContactDetails/WebAddress"/>
														</td>
														<td width="25%">
															<font class="titulopeque">Email:</font>&#160;&#160;&#160;
															<xsl:value-of select="LegalEntity/ContactDetails/ElectronicMail"/>
														</td>
													</tr>
													<tr>
														<td width="25%">
															<font class="titulopeque">Personas contacto:</font>&#160;&#160;&#160;
															<xsl:value-of select="LegalEntity/ContactDetails/ContactPersons"/>
														</td>
														<td width="25%">
															<font class="titulopeque">CnoCnae:</font>&#160;&#160;&#160;
															<xsl:value-of select="LegalEntity/ContactDetails/CnoCnae"/>
														</td>
														<td width="25%">
															<font class="titulopeque">Código INE:</font>&#160;&#160;&#160;
															<xsl:value-of select="LegalEntity/ContactDetails/INETownCode"/>
														</td>
														<td width="25%">
															<font class="titulopeque">Otros:</font>&#160;&#160;&#160;
															<xsl:value-of select="LegalEntity/ContactDetails/AdditionalContactDetails"/>
														</td>
													</tr>
												</table>
											</td>
										</tr>
									</xsl:if>
								</xsl:if>
								<xsl:if test='Individual!=""' >
									<tr>
										<td valign="top" width="10%">
										<font class="titulopeque">
											DIRECCIÓN:
										</font>
										</td>
										<td valign="top" width="40%">
											<xsl:if test='Individual/AddressInSpain!=""' >
												<xsl:value-of select="Individual/AddressInSpain/Address"/><br/>
												<xsl:value-of select="Individual/AddressInSpain/PostCode"/>&#160;&#160;&#160;
												<xsl:value-of select="Individual/AddressInSpain/Town"/><br/>
												<xsl:value-of select="Individual/AddressInSpain/Province"/><br/>
												<xsl:value-of select="Individual/AddressInSpain/CountryCode"/>
											</xsl:if>
											<xsl:if test='Individual/OverseasAddress!=""' >
												<xsl:value-of select="Individual/OverseasAddress/Address"/><br/>
												<xsl:value-of select="Individual/OverseasAddress/PostCodeAndTown"/><br/>
												<xsl:value-of select="Individual/OverseasAddress/Province"/><br/>
												<xsl:value-of select="Individual/OverseasAddress/CountryCode"/>
											</xsl:if>
										</td>
									</tr>
									<xsl:if test='Individual/ContactDetails!=""' >
										<tr>
											<td width="30%" colspan="3">
											<font class="titulopeque">
												DATOS DE CONTACTO:
											</font>
											</td>
										</tr>
										<tr>
											<td colspan="3">
												<table border="0" cellpadding="0" cellspacing="0" width="100%">
													<tr>
														<td width="25%">
															<font class="titulopeque">Teléfono:</font>&#160;&#160;&#160;
															<xsl:value-of select="Individual/ContactDetails/Telephone"/>
														</td>
														<td width="25%">
															<font class="titulopeque">Fax:</font>&#160;&#160;&#160;
															<xsl:value-of select="Individual/ContactDetails/TeleFax"/>
														</td>
														<td width="25%">
															<font class="titulopeque">Web:</font>&#160;&#160;&#160;
															<xsl:value-of select="Individual/ContactDetails/WebAddress"/>
														</td>
														<td width="25%">
															<font class="titulopeque">Email:</font>&#160;&#160;&#160;
															<xsl:value-of select="Individual/ContactDetails/ElectronicMail"/>
														</td>
													</tr>
													<tr>
														<td width="25%">
															<font class="titulopeque">Personas contacto:</font>&#160;&#160;&#160;
															<xsl:value-of select="Individual/ContactDetails/ContactPersons"/>
														</td>
														<td width="25%">
															<font class="titulopeque">CnoCnae:</font>&#160;&#160;&#160;
															<xsl:value-of select="Individual/ContactDetails/CnoCnae"/>
														</td>
														<td width="25%">
															<font class="titulopeque">Código INE:</font>&#160;&#160;&#160;
															<xsl:value-of select="Individual/ContactDetails/INETownCode"/>
														</td>
														<td width="25%">
															<font class="titulopeque">Otros:</font>&#160;&#160;&#160;
															<xsl:value-of select="Individual/ContactDetails/AdditionalContactDetails"/>
														</td>
													</tr>
												</table>
											</td>
										</tr>
										</xsl:if>
								</xsl:if>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</xsl:template>
	<xsl:template match="//m:Facturae/FileHeader/FactoringAssignmentData">
		 <tr id="cesionario">
			 <td width="100%">
				<table border="0" cellpadding="0" cellspacing="0" width="100%">
					<tr>
						 <td width="100%">
							<table border="0" cellpadding="0" cellspacing="0" width="100%">
								<tr>
									<td colspan="3">
										&#160;
									</td>
								</tr>
								<tr>
									<td colspan="3">
										<hr/>
									</td>
								</tr>
								<tr>
									<td colspan="2">
										<font class="titulo2">
											DATOS CESIONARIO
										</font>
									</td>
									<td align="right">

									</td>
								</tr>
								<tr>
									<td colspan="3">&#160;</td>
								</tr>
								<tr>
									<xsl:if test='Assignee/LegalEntity!=""' >
										<td  width="50%" colspan="2">
											<font class="titulopeque">
												RAZÓN SOCIAL:
											</font>
											&#160;&#160;&#160;
											<xsl:value-of select="Assignee/LegalEntity/CorporateName"/>
										</td>
									</xsl:if>
									<xsl:if test='Assignee/Individual!=""' >
										<td  width="50%" colspan="2">
											<font class="titulopeque">
												NOMBRE Y APELLIDOS:
											</font>
											&#160;&#160;&#160;
											<xsl:value-of select="Assignee/Individual/Name"/>&#160;
											<xsl:value-of select="Assignee/Individual/FirstSurname"/>&#160;
											<xsl:value-of select="Assignee/Individual/SecondSurname"/>&#160;
										</td>
									</xsl:if>
									<td width="50%">
										<font class="titulopeque">
											NIF / CIF:
										</font>
										&#160;&#160;&#160;
										<xsl:value-of select="Assignee/TaxIdentification/TaxIdentificationNumber"/>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr id="datosCesionario" style="">
						<td width="100%">
							<table border="0" cellpadding="0" cellspacing="0" width="100%">
								<tr>
									<td width="50%" colspan="2">
										<font class="titulopeque">
											TIPO PERSONA:
										</font>
										&#160;&#160;&#160;
										<script>
											document.write(descTipoPersona('<xsl:value-of select="Assignee/TaxIdentification/PersonTypeCode"/>'));
										</script>
									</td>
									<td width="50%">
										<font class="titulopeque">
											TIPO RESIDENCIA:
										</font>
										&#160;&#160;&#160;
										<script>
											document.write(descTipoResidencia('<xsl:value-of select="Assignee/TaxIdentification/ResidenceTypeCode"/>'));
										</script>
									</td>
								</tr>
								<tr>
									<td width="100%" colspan="3">
										<font class="titulopeque">
											CLÁUSULA:
										</font>
										&#160;&#160;&#160;
										<xsl:value-of select="FactoringAssignmentClauses"/>
									</td>
								</tr>
								<xsl:if test='Assignee/LegalEntity!=""' >
									<tr>
										<td valign="top" width="10%">
											<font class="titulopeque">
												DIRECCIÓN:
											</font>
										</td>
										<td valign="top" width="40%">
											<xsl:if test='Assignee/LegalEntity/AddressInSpain!=""' >
												<xsl:value-of select="Assignee/LegalEntity/AddressInSpain/Address"/><br/>
												<xsl:value-of select="Assignee/LegalEntity/AddressInSpain/PostCode"/>&#160;&#160;&#160;
												<xsl:value-of select="Assignee/LegalEntity/AddressInSpain/Town"/><br/>
												<xsl:value-of select="Assignee/LegalEntity/AddressInSpain/Province"/><br/>
												<xsl:value-of select="Assignee/LegalEntity/AddressInSpain/CountryCode"/>
											</xsl:if>
											<xsl:if test='Assignee/LegalEntity/OverseasAddress!=""' >
												<xsl:value-of select="Assignee/LegalEntity/OverseasAddress/Address"/><br/>
												<xsl:value-of select="Assignee/LegalEntity/OverseasAddress/PostCodeAndTown"/><br/>
												<xsl:value-of select="Assignee/LegalEntity/OverseasAddress/Province"/><br/>
												<xsl:value-of select="Assignee/LegalEntity/OverseasAddress/CountryCode"/>
											</xsl:if>
										</td>
										<xsl:if test='Assignee/LegalEntity/TradeName!=""' >
											<td valign="top" width="50%">
												<font class="titulopeque">
													NOMBRE COMERCIAL:
												</font>
												&#160;&#160;&#160;
												<xsl:value-of select="Assignee/LegalEntity/TradeName"/>
											</td>
										</xsl:if>
									</tr>
									<xsl:if test='Assignee/LegalEntity/RegistrationData!=""' >
										<tr>
											<td width="30%" colspan="3">
											<font class="titulopeque">
												DATOS REGISTRALES:
											</font>
											</td>
										</tr>
										<tr>
											<td colspan="3">
												<table border="0" cellpadding="0" cellspacing="0" width="100%">
													<tr>
														<td width="25%">
															<font class="titulopeque">Libro:</font>&#160;&#160;&#160;
															<xsl:value-of select="Assignee/LegalEntity/RegistrationData/Book"/>
														</td>
														<td width="25%">
															<font class="titulopeque">Registro mercantil:</font>&#160;&#160;&#160;
															<xsl:value-of select="Assignee/LegalEntity/RegistrationData/RegisterOfCompaniesLocation"/>
														</td>
														<td width="25%">
															<font class="titulopeque">Hoja:</font>&#160;&#160;&#160;
															<xsl:value-of select="Assignee/LegalEntity/RegistrationData/Sheet"/>
														</td>
														<td width="25%">
															<font class="titulopeque">Folio:</font>&#160;&#160;&#160;
															<xsl:value-of select="Assignee/LegalEntity/RegistrationData/Folio"/>
														</td>
													</tr>
													<tr>
														<td width="25%">
															<font class="titulopeque">Sección:</font>&#160;&#160;&#160;
															<xsl:value-of select="Assignee/LegalEntity/RegistrationData/Section"/>
														</td>
														<td width="25%">
															<font class="titulopeque">Tomo:</font>&#160;&#160;&#160;
															<xsl:value-of select="Assignee/LegalEntity/RegistrationData/Volume"/>
														</td>
														<td width="25%">
															<font class="titulopeque">Otros:</font>&#160;&#160;&#160;
															<xsl:value-of select="Assignee/LegalEntity/RegistrationData/AdditionalRegistrationData"/>
														</td>
													</tr>
												</table>
											</td>
										</tr>
									</xsl:if>
									<xsl:if test='Assignee/LegalEntity/ContactDetails!=""' >
										<tr>
											<td width="30%" colspan="3">
											<font class="titulopeque">
												DATOS DE CONTACTO:
											</font>
											</td>
										</tr>
										<tr>
											<td colspan="3">
												<table border="0" cellpadding="0" cellspacing="0" width="100%">
													<tr>
														<td width="25%">
															<font class="titulopeque">Teléfono:</font>&#160;&#160;&#160;
															<xsl:value-of select="Assignee/LegalEntity/ContactDetails/Telephone"/>
														</td>
														<td width="25%">
															<font class="titulopeque">Fax:</font>&#160;&#160;&#160;
															<xsl:value-of select="Assignee/LegalEntity/ContactDetails/TeleFax"/>
														</td>
														<td width="25%">
															<font class="titulopeque">Web:</font>&#160;&#160;&#160;
															<xsl:value-of select="Assignee/LegalEntity/ContactDetails/WebAddress"/>
														</td>
														<td width="25%">
															<font class="titulopeque">Email:</font>&#160;&#160;&#160;
															<xsl:value-of select="Assignee/LegalEntity/ContactDetails/ElectronicMail"/>
														</td>
													</tr>
													<tr>
														<td width="25%">
															<font class="titulopeque">Personas contacto:</font>&#160;&#160;&#160;
															<xsl:value-of select="Assignee/LegalEntity/ContactDetails/ContactPersons"/>
														</td>
														<td width="25%">
															<font class="titulopeque">CnoCnae:</font>&#160;&#160;&#160;
															<xsl:value-of select="Assignee/LegalEntity/ContactDetails/CnoCnae"/>
														</td>
														<td width="25%">
															<font class="titulopeque">Código INE:</font>&#160;&#160;&#160;
															<xsl:value-of select="Assignee/LegalEntity/ContactDetails/INETownCode"/>
														</td>
														<td width="25%">
															<font class="titulopeque">Otros:</font>&#160;&#160;&#160;
															<xsl:value-of select="Assignee/LegalEntity/ContactDetails/AdditionalContactDetails"/>
														</td>
													</tr>
												</table>
											</td>
										</tr>
									</xsl:if>
								</xsl:if>
								<xsl:if test='Assignee/Individual!=""' >
									<tr>
										<td valign="top" width="10%">
											<font class="titulopeque">
												DIRECCIÓN:
											</font>
										</td>
										<td valign="top" width="40%">
											<xsl:if test='Assignee/Individual/AddressInSpain!=""' >
												<xsl:value-of select="Assignee/Individual/AddressInSpain/Address"/><br/>
												<xsl:value-of select="Assignee/Individual/AddressInSpain/PostCode"/>&#160;&#160;&#160;
												<xsl:value-of select="Assignee/Individual/AddressInSpain/Town"/><br/>
												<xsl:value-of select="Assignee/Individual/AddressInSpain/Province"/><br/>
												<xsl:value-of select="Assignee/Individual/AddressInSpain/CountryCode"/>
											</xsl:if>
											<xsl:if test='Assignee/Individual/OverseasAddress!=""' >
												<xsl:value-of select="Assignee/Individual/OverseasAddress/Address"/><br/>
												<xsl:value-of select="Assignee/Individual/OverseasAddress/PostCodeAndTown"/><br/>
												<xsl:value-of select="Assignee/Individual/OverseasAddress/Province"/><br/>
												<xsl:value-of select="Assignee/Individual/OverseasAddress/CountryCode"/>
											</xsl:if>
										</td>
									</tr>
									<xsl:if test='Assignee/Individual/ContactDetails!=""' >
										<tr>
											<td width="30%" colspan="3">
											<font class="titulopeque">
												DATOS DE CONTACTO:
											</font>
											</td>
										</tr>
										<tr>
											<td colspan="3">
												<table border="0" cellpadding="0" cellspacing="0" width="100%">
													<tr>
														<td width="25%">
															<font class="titulopeque">Teléfono:</font>&#160;&#160;&#160;
															<xsl:value-of select="Assignee/Individual/ContactDetails/Telephone"/>
														</td>
														<td width="25%">
															<font class="titulopeque">Fax:</font>&#160;&#160;&#160;
															<xsl:value-of select="Assignee/Individual/ContactDetails/TeleFax"/>
														</td>
														<td width="25%">
															<font class="titulopeque">Web:</font>&#160;&#160;&#160;
															<xsl:value-of select="Assignee/Individual/ContactDetails/WebAddress"/>
														</td>
														<td width="25%">
															<font class="titulopeque">Email:</font>&#160;&#160;&#160;
															<xsl:value-of select="Assignee/Individual/ContactDetails/ElectronicMail"/>
														</td>
													</tr>
													<tr>
														<td width="25%">
															<font class="titulopeque">Personas contacto:</font>&#160;&#160;&#160;
															<xsl:value-of select="Assignee/Individual/ContactDetails/ContactPersons"/>
														</td>
														<td width="25%">
															<font class="titulopeque">CnoCnae:</font>&#160;&#160;&#160;
															<xsl:value-of select="Assignee/Individual/ContactDetails/CnoCnae"/>
														</td>
														<td width="25%">
															<font class="titulopeque">Código INE:</font>&#160;&#160;&#160;
															<xsl:value-of select="Assignee/Individual/ContactDetails/INETownCode"/>
														</td>
														<td width="25%">
															<font class="titulopeque">Otros:</font>&#160;&#160;&#160;
															<xsl:value-of select="Assignee/Individual/ContactDetails/AdditionalContactDetails"/>
														</td>
													</tr>
												</table>
											</td>
										</tr>
									</xsl:if>
								</xsl:if>
								<tr>
									<td width="100%" colspan="3">
										<font class="titulopeque">
											DATOS DE PAGO:
										</font>
									</td>
								</tr>
								<tr>
									<td width="100%" colspan="3">
										<table border="1" cellpadding="0" cellspacing="0" width="100%">
											<tr>
												<td width="7%" align="center">
													<font class="titulopeque">FECHA VENC.</font>
												</td>
												<td width="6%" align="center">
													<font class="titulopeque">IMPORTE</font>
												</td>
												<td width="10%" align="center">
													<font class="titulopeque">FORMA DE PAGO</font>
												</td>
												<td width="26%" align="center">
													<font class="titulopeque">CUENTA</font>
												</td>
												<td width="10%" align="center">
													<font class="titulopeque">REFERENCIA</font>
												</td>
												<td width="11%" align="center">
													<font class="titulopeque">REFERENCIA DÉBITO</font>
												</td>
												<td width="8%" align="center">
													<font class="titulopeque">CÓD. ESTADÍSTICO</font>
												</td>
												<td width="22%" align="center">
													<font class="titulopeque">OBSERVACIONES</font>
												</td>
											</tr>
											<xsl:for-each select="PaymentDetails/Installment">
												<tr>
													<td width="7%" valign="top" align="center">
														<xsl:value-of select="substring(InstallmentDueDate,9,2)"/>-<xsl:value-of select="substring(InstallmentDueDate,6,2)"/>-<xsl:value-of select="substring(InstallmentDueDate,1,4)"/>
													</td>
													<td width="6%" valign="top" align="right">
														<xsl:value-of select="InstallmentAmount"/>
													</td>
													<td width="10%" valign="top"  align="center">
														<script>
															document.write(descFormaPago('<xsl:value-of select="PaymentMeans"/>'));
														</script>
													</td>
													<td width="26%" valign="top"  align="center">
														<xsl:choose>
															<xsl:when test='AccountToBeCredited!=""' >
																<table border="0" cellpadding="0" cellspacing="0" width="95%" align="center">
																	<xsl:if test='AccountToBeCredited/IBAN!=""' >
																		<tr>
																			<td width="30%">
																				IBAN:
																			</td>
																			<td width="70%">
																				<xsl:apply-templates select="AccountToBeCredited/IBAN"/>
																			</td>
																		</tr>
																	</xsl:if>
																	<xsl:if test='AccountToBeCredited/AccountNumber!=""' >
																		<tr>
																			<td width="30%">
																				Núm. cuenta:
																			</td>
																			<td width="70%">
																				<xsl:apply-templates select="AccountToBeCredited/AccountNumber"/>
																			</td>
																		</tr>
																	</xsl:if>
																	<xsl:if test='AccountToBeCredited/BankCode!=""' >
																		<tr>
																			<td>
																				Entidad:
																			</td>
																			<td>
																				<xsl:apply-templates select="AccountToBeCredited/BankCode"/>
																			</td>
																		</tr>
																	</xsl:if>
																	<xsl:if test='AccountToBeCredited/BranchCode!=""' >
																		<tr>
																			<td>
																				Oficina:
																			</td>
																			<td>
																				<xsl:apply-templates select="AccountToBeCredited/BranchCode"/>
																			</td>
																		</tr>
																	</xsl:if>
																	<tr>
																		<td width="30%">
																			SWIFT:
																		</td>
																		<td width="70%">
																			<xsl:apply-templates select="AccountToBeCredited/BIC"/>
																		</td>
																	</tr>
																	<xsl:if test='AccountToBeCredited/BranchInSpainAddress!=""' >
																		<tr>
																			<td valign="top">
																				Dirección:
																			</td>
																			<td>
																				<xsl:value-of select="AccountToBeCredited/BranchInSpainAddress/Address"/><br/>
																				<xsl:value-of select="AccountToBeCredited/BranchInSpainAddress/PostCode"/>&#160;&#160;&#160;
																				<xsl:value-of select="AccountToBeCredited/BranchInSpainAddress/Town"/><br/>
																				<xsl:value-of select="AccountToBeCredited/BranchInSpainAddress/Province"/><br/>
																				<xsl:value-of select="AccountToBeCredited/BranchInSpainAddress/CountryCode"/>
																			</td>
																		</tr>
																	</xsl:if>
																	<xsl:if test='AccountToBeCredited/OverseasBranchAddress!=""' >
																		<tr>
																			<td valign="top">
																				Dirección:
																			</td>
																			<td>
																				<xsl:value-of select="AccountToBeCredited/OverseasBranchAddress/Address"/><br/>
																				<xsl:value-of select="AccountToBeCredited/OverseasBranchAddress/PostCodeAndTown"/><br/>
																				<xsl:value-of select="AccountToBeCredited/OverseasBranchAddress/Province"/><br/>
																				<xsl:value-of select="AccountToBeCredited/OverseasBranchAddress/CountryCode"/>
																			</td>
																		</tr>
																	</xsl:if>
																</table>
															</xsl:when>
															<xsl:when test='AccountToBeDebited!=""' >
																<table border="0" cellpadding="0" cellspacing="0" width="95%" align="center">
																	<xsl:if test='AccountToBeDebited/IBAN!=""' >
																		<tr>
																			<td width="30%">
																				IBAN:
																			</td>
																			<td width="70%">
																				<xsl:apply-templates select="AccountToBeDebited/IBAN"/>
																			</td>
																		</tr>
																	</xsl:if>
																	<xsl:if test='AccountToBeDebited/AccountNumber!=""' >
																		<tr>
																			<td width="30%">
																				Núm. cuenta:
																			</td>
																			<td width="70%">
																				<xsl:apply-templates select="AccountToBeDebited/AccountNumber"/>
																			</td>
																		</tr>
																	</xsl:if>
																	<xsl:if test='AccountToBeDebited/BankCode!=""' >
																		<tr>
																			<td>
																				Entidad:
																			</td>
																			<td>
																				<xsl:apply-templates select="AccountToBeDebited/BankCode"/>
																			</td>
																		</tr>
																	</xsl:if>
																	<xsl:if test='AccountToBeDebited/BranchCode!=""' >
																		<tr>
																			<td>
																				Oficina:
																			</td>
																			<td>
																				<xsl:apply-templates select="AccountToBeDebited/BranchCode"/>
																			</td>
																		</tr>
																	</xsl:if>
																	<tr>
																		<td width="30%">
																			SWIFT:
																		</td>
																		<td width="70%">
																			<xsl:apply-templates select="AccountToBeDebited/BIC"/>
																		</td>
																	</tr>
																	<xsl:if test='AccountToBeDebited/BranchInSpainAddress!=""' >
																		<tr>
																			<td valign="top">
																				Dirección:
																			</td>
																			<td>
																				<xsl:value-of select="AccountToBeDebited/BranchInSpainAddress/Address"/><br/>
																				<xsl:value-of select="AccountToBeDebited/BranchInSpainAddress/PostCode"/>&#160;&#160;&#160;
																				<xsl:value-of select="AccountToBeDebited/BranchInSpainAddress/Town"/><br/>
																				<xsl:value-of select="AccountToBeDebited/BranchInSpainAddress/Province"/><br/>
																				<xsl:value-of select="AccountToBeDebited/BranchInSpainAddress/CountryCode"/>
																			</td>
																		</tr>
																	</xsl:if>
																	<xsl:if test='AccountToBeDebited/OverseasBranchAddress!=""' >
																		<tr>
																			<td valign="top">
																				Dirección:
																			</td>
																			<td>
																				<xsl:value-of select="AccountToBeDebited/OverseasBranchAddress/Address"/><br/>
																				<xsl:value-of select="AccountToBeDebited/OverseasBranchAddress/PostCodeAndTown"/><br/>
																				<xsl:value-of select="AccountToBeDebited/OverseasBranchAddress/Province"/><br/>
																				<xsl:value-of select="AccountToBeDebited/OverseasBranchAddress/CountryCode"/>
																			</td>
																		</tr>
																	</xsl:if>
																</table>
															</xsl:when>
															<xsl:otherwise>
																&#160;
															</xsl:otherwise>
														</xsl:choose>
													</td>
													<td width="10%" valign="top">
														<xsl:choose>
															<xsl:when test='PaymentReconciliationReference!=""' >
																<xsl:apply-templates select="PaymentReconciliationReference"/>
															</xsl:when>
															<xsl:otherwise>
																&#160;
															</xsl:otherwise>
														</xsl:choose>
													</td>
													<td width="11%" valign="top">
														<xsl:choose>
															<xsl:when test='DebitReconciliationReference!=""' >
																<xsl:apply-templates select="DebitReconciliationReference"/>
															</xsl:when>
															<xsl:otherwise>
																&#160;
															</xsl:otherwise>
														</xsl:choose>
													</td>
													<td width="8%" valign="top">
														<xsl:choose>
															<xsl:when test='RegulatoryReportingData!=""' >
																<xsl:apply-templates select="RegulatoryReportingData"/>
															</xsl:when>
															<xsl:otherwise>
																&#160;
															</xsl:otherwise>
														</xsl:choose>
													</td>
													<td width="22%" valign="top">
														<xsl:choose>
															<xsl:when test='CollectionAdditionalInformation!=""' >
																<xsl:apply-templates select="CollectionAdditionalInformation"/>
															</xsl:when>
															<xsl:otherwise>
																&#160;
															</xsl:otherwise>
														</xsl:choose>
													</td>
												</tr>
											</xsl:for-each>
										</table>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</xsl:template>
	<xsl:template match="//m:Facturae/Invoices/Invoice">
		<xsl:variable name="numFactura" select="InvoiceHeader/InvoiceNumber"/>
		<tr id="{$numFactura}" style="">
			<td width="100%">
				<table border="0" cellpadding="0" cellspacing="0" width="100%">
					<tr>
						<td>&#160;</td>
					</tr>
					<tr>
						<td>
							<hr/>
						</td>
					</tr>
					<tr>
						<td>
							<font class="titulo2">RESUMEN FACTURA</font>
						</td>
					</tr>
					<tr>
						<td>&#160;</td>
					</tr>
					<tr>
						<td width="100%">
							<table border="1" cellpadding="0" cellspacing="0" width="100%">
								<tr>
									<td>
										<table border="0" cellpadding="0" cellspacing="0" width="100%">
											<tr>
												<td align="center" width="20%">
													<font class="titulopeque">NUMERO</font>
													<br/><xsl:value-of select="InvoiceHeader/InvoiceNumber"/>
												</td>
												<td align="center" width="20%">
													<font class="titulopeque">SERIE</font>
													<br/>
													<xsl:choose>
														<xsl:when test='InvoiceHeader/InvoiceSeriesCode!=""' >
															<xsl:value-of select="InvoiceHeader/InvoiceSeriesCode"/>
														</xsl:when>
														<xsl:otherwise>
															-
														</xsl:otherwise>
													</xsl:choose>
												</td>
												<td align="center" width="20%">
													<font class="titulopeque">TIPO</font>
													<br/><xsl:choose>
														<xsl:when test='InvoiceHeader/InvoiceDocumentType="FC"' >
															Factura Completa
														</xsl:when>
														<xsl:when test='InvoiceHeader/InvoiceDocumentType="FA"' >
															Factura abreviada
														</xsl:when>
														<xsl:when test='InvoiceHeader/InvoiceDocumentType="AF"' >
															AutoFactura
														</xsl:when>
														<xsl:otherwise>
															<xsl:value-of select="InvoiceHeader/InvoiceDocumentType"/>
														</xsl:otherwise>
													</xsl:choose>
												</td>
												<td align="center" width="20%">
													<font class="titulopeque">CLASE</font>
													<br/><xsl:choose>
														<xsl:when test='InvoiceHeader/InvoiceClass="OO"' >
															Original
														</xsl:when>
														<xsl:when test='InvoiceHeader/InvoiceClass="OR"' >
															Original rectificativa
														</xsl:when>
														<xsl:when test='InvoiceHeader/InvoiceClass="OC"' >
															Original recapitulativa
														</xsl:when>
														<xsl:when test='InvoiceHeader/InvoiceClass="CO"' >
															Copia original
														</xsl:when>
														<xsl:when test='InvoiceHeader/InvoiceClass="CR"' >
															Copia rectificativa
														</xsl:when>
														<xsl:when test='InvoiceHeader/InvoiceClass="CC"' >
															Copia recapitulativa
														</xsl:when>
														<xsl:otherwise>
															<xsl:value-of select="InvoiceHeader/InvoiceClass"/>
														</xsl:otherwise>
													</xsl:choose>
												</td>
												<td align="center" width="20%">
													<font class="titulopeque">LENGUA</font>
													<br/>
													<xsl:choose>
														<xsl:when test='InvoiceIssueData/LanguageName!=""' >
															<script>
																document.write(descLengua('<xsl:value-of select="InvoiceIssueData/LanguageName"/>'));
															</script>
														</xsl:when>
														<xsl:otherwise>
															-
														</xsl:otherwise>
													</xsl:choose>
												</td>
											</tr>
										</table>
									</td>
								</tr>
								<tr>
									<td>
										<table border="0" cellpadding="0" cellspacing="0" width="100%">
											<tr>
												<td align="center" width="25%">
													<font class="titulopeque">FECHA OPER.</font>
													<br/>
														<xsl:choose>
															<xsl:when test='InvoiceIssueData/OperationDate!=""' >
																<xsl:value-of select="substring(InvoiceIssueData/OperationDate,9,2)"/>-<xsl:value-of select="substring(InvoiceIssueData/OperationDate,6,2)"/>-<xsl:value-of select="substring(InvoiceIssueData/OperationDate,1,4)"/>
																</xsl:when>
															<xsl:otherwise>
																-
															</xsl:otherwise>
														</xsl:choose>
												</td>
												<td align="center" width="25%">
													<font class="titulopeque">FECHA EXPED.</font>
													<br/>
														<xsl:value-of select="substring(InvoiceIssueData/IssueDate,9,2)"/>-<xsl:value-of select="substring(InvoiceIssueData/IssueDate,6,2)"/>-<xsl:value-of select="substring(InvoiceIssueData/IssueDate,1,4)"/>
												</td>
												<td align="center" width="25%">
													<font class="titulopeque">LUGAR EXPED.</font>
													<br/>
													<xsl:choose>
														<xsl:when test='InvoiceIssueData/PlaceOfIssue!=""' >
															<xsl:value-of select="InvoiceIssueData/PlaceOfIssue/PostCode"/>&#160;<xsl:value-of select="InvoiceIssueData/PlaceOfIssue/PlaceOfIssueDescription"/>
														</xsl:when>
														<xsl:otherwise>
															-
														</xsl:otherwise>
													</xsl:choose>
												</td>
												<td align="center" width="25%">
													<font class="titulopeque">PERIODO FACT.</font>
													<br/>
													<xsl:choose>
														<xsl:when test='InvoiceIssueData/InvoicingPeriod!=""' >
															<xsl:value-of select="substring(InvoiceIssueData/InvoicingPeriod/StartDate,9,2)"/>-<xsl:value-of select="substring(InvoiceIssueData/InvoicingPeriod/StartDate,6,2)"/>-<xsl:value-of select="substring(InvoiceIssueData/InvoicingPeriod/StartDate,1,4)"/> -
															<xsl:value-of select="substring(InvoiceIssueData/InvoicingPeriod/EndDate,9,2)"/>-<xsl:value-of select="substring(InvoiceIssueData/InvoicingPeriod/EndDate,6,2)"/>-<xsl:value-of select="substring(InvoiceIssueData/InvoicingPeriod/EndDate,1,4)"/>
														</xsl:when>
														<xsl:otherwise>
															-
														</xsl:otherwise>
													</xsl:choose>
												</td>
											</tr>
										</table>
									</td>
								</tr>
								<tr>
									<td>
										<table border="0" cellpadding="0" cellspacing="0" width="100%">
											<tr>
												<td align="center" width="25%">
													<font class="titulopeque">MONEDA OPERACIÓN</font><br/>
													<xsl:value-of select="InvoiceIssueData/InvoiceCurrencyCode"/>
												</td>
												<xsl:if test='InvoiceIssueData/InvoiceCurrencyCode!="EUR"'>
													<td align="center" width="25%">
														<font class="titulopeque">TIPO CAMBIO</font>
														<br/><xsl:value-of select="InvoiceIssueData/ExchangeRateDetails/ExchangeRate"/>
													</td>
													<td align="center" width="25%">
														<font class="titulopeque">FECHA TIPO CAMBIO</font>
														<br/><xsl:value-of select="substring(InvoiceIssueData/ExchangeRateDetails/ExchangeRateDate,9,2)"/>-<xsl:value-of select="substring(InvoiceIssueData/ExchangeRateDetails/ExchangeRateDate,6,2)"/>-<xsl:value-of select="substring(InvoiceIssueData/ExchangeRateDetails/ExchangeRateDate,1,4)"/>
													</td>
												</xsl:if>
												<td align="center" width="25%">
													<font class="titulopeque">MONEDA IMPUESTO</font>
													<br/><xsl:value-of select="InvoiceIssueData/TaxCurrencyCode"/>
												</td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<xsl:apply-templates select="InvoiceHeader/Corrective"/>
					<tr>
						<td>&#160;</td>
					</tr>
					<tr>
						<td>
							<hr/>
						</td>
					</tr>
					<tr>
						<td>
							<font class="titulo2">DETALLES</font>
						</td>
					</tr>
					<tr>
						<td>&#160;</td>
					</tr>
					<tr>
						<td width="100%">
							<table border="1" cellpadding="0" cellspacing="0" width="100%">
								<tr>
									<td width="48%" align="center">
										<font class="titulopeque">DESCRIPCIÓN</font>
									</td>
									<td width="12%" align="center">
										<font class="titulopeque">FECHA OPER.</font>
									</td>
									<td width="10%" align="center">
										<font class="titulopeque">CANTIDAD</font>
									</td>
									<td width="15%" align="center">
										<font class="titulopeque">IMP. UNITARIO</font>
									</td>
									<td width="15%" align="center">
										<font class="titulopeque">TOTAL</font>
									</td>
								</tr>
								<xsl:for-each select="Items/InvoiceLine">
									<tr style="cursor:hand" onclick="mostrarDetalle('{$numFactura}','{ItemDescription}')" onMouseOver="this.style.background='#DDEEEE'" onMouseOut="this.style.background='#FFFFFF'">
										<td width="48%" valign="top">
											<xsl:apply-templates select="ItemDescription"/>
										</td>
										<td width="12%" valign="top" align="center">
											<xsl:choose>
												<xsl:when test='TransactionDate!=""' >
													<xsl:value-of select="substring(TransactionDate,9,2)"/>-<xsl:value-of select="substring(TransactionDate,6,2)"/>-<xsl:value-of select="substring(TransactionDate,1,4)"/>
												</xsl:when>
												<xsl:otherwise>
													&#160;
												</xsl:otherwise>
											</xsl:choose>
										</td>
										<td width="10%" valign="top" align="right">
											<xsl:value-of select="Quantity"/>
										</td>
										<td width="15%" valign="top" align="right">
											<xsl:value-of select="UnitPriceWithoutTax"/>
										</td>
										<td width="15%" valign="top" align="right">
											<xsl:value-of select="TotalCost"/>
										</td>
									</tr>
								</xsl:for-each>
							</table>
						</td>
					</tr>
					<tr>
						<td>&#160;</td>
					</tr>
					<tr>
						<td>
							<hr/>
						</td>
					</tr>
					<tr>
						<td width="100%">
							<table border="0" cellpadding="0" cellspacing="0" width="100%">
								<tr>
									<td>
										<font class="titulo2">IMPORTES</font>
									</td>
								</tr>
								<tr>
									<td>&#160;</td>
								</tr>
								<tr>
									<td width="100%">
										<table border="0" cellpadding="0" cellspacing="0" width="100%">
											<tr>
												<td width="80%" align="right">
													<font class="titulopeque">IMPORTE BRUTO&#160;&#160;&#160;&#160;&#160;</font>
												</td>
												<td width="20%" align="center">
													<table border="1" cellpadding="0" cellspacing="0" width="100%">
														<tr>
															<td align="right">
																<font class="titulopeque">
																	<xsl:value-of select="InvoiceTotals/TotalGrossAmount"/>
																</font>
															</td>
														</tr>
													</table>
												</td>
											</tr>
										</table>
									</td>
								</tr>
								<xsl:if test='InvoiceTotals/GeneralDiscounts!=""' >
								<tr>
									<td>
										<font class="titulopeque"><i>DESCUENTOS</i></font>
										<table border="1" cellpadding="0" cellspacing="0" width="100%">
											<tr>
												<td width="70%" valign="top" align="center">
													<font class="titulopeque">CONCEPTO</font>
												</td>
												<td width="10%" valign="top" align="center">
													<font class="titulopeque">TIPO (%)</font>
												</td>
												<td width="20%" valign="top" align="center">
													<font class="titulopeque">IMPORTE</font>
												</td>
											</tr>
											<tr>
												<td width="70%" valign="top">
													<table border="0" cellpadding="0" cellspacing="0" width="100%">
														<xsl:for-each select="InvoiceTotals/GeneralDiscounts/Discount">
															<tr>
																<td width="100%">
																	<xsl:apply-templates select="DiscountReason"/>
																</td>
															</tr>
														</xsl:for-each>
													</table>
												</td>
												<td width="10%" valign="top">
													<table border="0" cellpadding="0" cellspacing="0" width="100%">
														<xsl:for-each select="InvoiceTotals/GeneralDiscounts/Discount">
															<tr>
																<td width="100%" align="center">
																	<xsl:choose>
																		<xsl:when test='DiscountRate!=""' >
																			<xsl:value-of select="DiscountRate"/>
																		</xsl:when>
																		<xsl:otherwise>
																			-
																		</xsl:otherwise>
																	</xsl:choose>
																</td>
															</tr>
														</xsl:for-each>
													</table>
												</td>
												<td width="20%" valign="top">
													<table border="0" cellpadding="0" cellspacing="0" width="100%">
														<xsl:for-each select="InvoiceTotals/GeneralDiscounts/Discount">
															<tr>
																<td align="right">
																	<xsl:value-of select="DiscountAmount"/>
																</td>
															</tr>
														</xsl:for-each>
													</table>
												</td>
											</tr>
										</table>
									</td>
								</tr>
								<tr>
									<td>&#160;</td>
								</tr>
								<tr>
									<td width="100%">
										<table border="0" cellpadding="0" cellspacing="0" width="100%">
											<tr>
												<td width="80%" align="right">
													<font class="titulopeque">TOTAL DESCUENTOS&#160;&#160;&#160;&#160;&#160;</font>
												</td>
												<td width="20%" align="center">
													<table border="1" cellpadding="0" cellspacing="0" width="100%">
														<tr>
															<td align="right">
																<font class="titulopeque">
																	<xsl:value-of select="InvoiceTotals/TotalGeneralDiscounts"/>
																</font>
															</td>
														</tr>
													</table>
												</td>
											</tr>
										</table>
									</td>
								</tr>
								<tr>
									<td>&#160;</td>
								</tr>
								</xsl:if>
								<xsl:if test='InvoiceTotals/GeneralSurcharges!=""' >
								<tr>
									<td>
										<font class="titulopeque"><i>RECARGOS</i></font>
										<table border="1" cellpadding="0" cellspacing="0" width="100%">
											<tr>
												<td width="70%" valign="top" align="center">
													<font class="titulopeque">CONCEPTO</font>
												</td>
												<td width="10%" valign="top" align="center">
													<font class="titulopeque">TIPO (%)</font>
												</td>
												<td width="20%" valign="top" align="center">
													<font class="titulopeque">IMPORTE</font>
												</td>
											</tr>
											<tr>
												<td width="70%" valign="top">
													<table border="0" cellpadding="0" cellspacing="0" width="100%">
														<xsl:for-each select="InvoiceTotals/GeneralSurcharges/Charge">
															<tr>
																<td width="100%">
																	<xsl:apply-templates select="ChargeReason"/>
																</td>
															</tr>
														</xsl:for-each>
													</table>
												</td>
												<td width="10%" valign="top">
													<table border="0" cellpadding="0" cellspacing="0" width="100%">
														<xsl:for-each select="InvoiceTotals/GeneralSurcharges/Charge">
															<tr>
																<td width="100%" align="center">
																	<xsl:choose>
																		<xsl:when test='ChargeRate!=""' >
																			<xsl:value-of select="ChargeRate"/>
																		</xsl:when>
																		<xsl:otherwise>
																			-
																		</xsl:otherwise>
																	</xsl:choose>
																</td>
															</tr>
														</xsl:for-each>
													</table>
												</td>
												<td width="20%" valign="top">
													<table border="0" cellpadding="0" cellspacing="0" width="100%">
														<xsl:for-each select="InvoiceTotals/GeneralSurcharges/Charge">
															<tr>
																<td align="right">
																	<xsl:value-of select="ChargeAmount"/>
																</td>
															</tr>
														</xsl:for-each>
													</table>
												</td>
											</tr>
										</table>
									</td>
								</tr>
								<tr>
									<td>&#160;</td>
								</tr>
								<tr>
									<td width="100%">
										<table border="0" cellpadding="0" cellspacing="0" width="100%">
											<tr>
												<td width="80%" align="right">
													<font class="titulopeque">TOTAL RECARGOS&#160;&#160;&#160;&#160;&#160;</font>
												</td>
												<td width="20%" align="center">
													<table border="1" cellpadding="0" cellspacing="0" width="100%">
														<tr>
															<td align="right">
																<font class="titulopeque">
																	<xsl:value-of select="InvoiceTotals/TotalGeneralSurcharges"/>
																</font>
															</td>
														</tr>
													</table>
												</td>
											</tr>
										</table>
									</td>
								</tr>
								<tr>
									<td>&#160;</td>
								</tr>
								</xsl:if>
								<tr>
									<td width="100%">
										<table border="0" cellpadding="0" cellspacing="0" width="100%">
											<tr>
												<td width="80%" align="right">
													<font class="titulopeque">TOTAL IMPORTE BRUTO ANTES IMPUESTOS&#160;&#160;&#160;&#160;&#160;</font>
												</td>
												<td width="20%" align="center">
													<table border="1" cellpadding="0" cellspacing="0" width="100%">
														<tr>
															<td align="right">
																<font class="titulopeque">
																	<xsl:value-of select="InvoiceTotals/TotalGrossAmountBeforeTaxes"/>
																</font>
															</td>
														</tr>
													</table>
												</td>
											</tr>
										</table>
									</td>
								</tr>
								<tr>
									<td>&#160;</td>
								</tr>
								<xsl:if test='TaxesOutputs!=""' >
								<tr>
									<td>
										<font class="titulopeque"><i>IMPUESTOS REPERCUTIDOS</i></font>
										<xsl:choose>
											<xsl:when test='//m:Facturae/FileHeader/Batch/InvoiceCurrencyCode="EUR"'>
												<table border="1" cellpadding="0" cellspacing="0" width="100%">
													<tr>
														<td width="35%" valign="top" align="center">
															<font class="titulopeque">CLASE DE IMPUESTO</font>
														</td>
														<td width="10%" valign="top" align="center">
															<font class="titulopeque">TIPO (%)</font>
														</td>
														<xsl:choose>
															<xsl:when test='TaxesOutputs/Tax/SpecialTaxableBase!=""' >
																<td width="15%" valign="top" align="center">
																	<font class="titulopeque">BASE IMPONIBLE ESPECIAL</font>
																</td>
																<td width="15%" valign="top" align="center">
																	<font class="titulopeque">CUOTA ESPECIAL</font>
																</td>
															</xsl:when>
															<xsl:otherwise>
																<td width="15%" valign="top" align="center">
																	<font class="titulopeque">BASE IMPONIBLE</font>
																</td>
																<td width="15%" valign="top" align="center">
																	<font class="titulopeque">CUOTA</font>
																</td>
															</xsl:otherwise>
														</xsl:choose>
														<td width="10%" valign="top" align="center">
															<font class="titulopeque">RECARGO EQUIV. (%)</font>
														</td>
														<td width="15%" valign="top" align="center">
															<font class="titulopeque">CUOTA RECARGO EQUIV.</font>
														</td>
													</tr>
													<tr>
														<td width="35%" valign="top">
															<table border="0" cellpadding="0" cellspacing="0" width="100%">
																<xsl:for-each select="TaxesOutputs/Tax">
																	<tr>
																		<td width="100%">
																			<script>
																				document.write(descTipoImpuesto('<xsl:value-of select="TaxTypeCode"/>'));
																			</script>
																		</td>
																	</tr>
																</xsl:for-each>
															</table>
														</td>
														<td width="10%" valign="top">
															<table border="0" cellpadding="0" cellspacing="0" width="100%">
																<xsl:for-each select="TaxesOutputs/Tax">
																	<tr>
																		<td width="100%" align="center">
																			<xsl:choose>
																				<xsl:when test='TaxRate!=""' >
																					<xsl:value-of select="TaxRate"/>
																				</xsl:when>
																				<xsl:otherwise>
																					-
																				</xsl:otherwise>
																			</xsl:choose>
																		</td>
																	</tr>
																</xsl:for-each>
															</table>
														</td>
														<td width="15%" valign="top">
															<table border="0" cellpadding="0" cellspacing="0" width="100%">
																<xsl:for-each select="TaxesOutputs/Tax">
																	<tr>
																		<td width="100%" align="right">
																			<xsl:choose>
																				<xsl:when test='SpecialTaxableBase!=""' >
																					<xsl:value-of select="SpecialTaxableBase/TotalAmount"/>
																				</xsl:when>
																				<xsl:otherwise>
																					<xsl:value-of select="TaxableBase/TotalAmount"/>
																				</xsl:otherwise>
																			</xsl:choose>
																		</td>
																	</tr>
																</xsl:for-each>
															</table>
														</td>
														<td width="15%" valign="top">
															<table border="0" cellpadding="0" cellspacing="0" width="100%">
																<xsl:for-each select="TaxesOutputs/Tax">
																	<tr>
																		<td align="right">
																			<xsl:choose>
																				<xsl:when test='SpecialTaxAmount!=""' >
																					<xsl:value-of select="SpecialTaxAmount/TotalAmount"/>
																				</xsl:when>
																				<xsl:when test='TaxAmount!=""' >
																					<xsl:value-of select="TaxAmount/TotalAmount"/>
																				</xsl:when>
																				<xsl:otherwise>
																					-
																				</xsl:otherwise>
																			</xsl:choose>
																		</td>
																	</tr>
																</xsl:for-each>
															</table>
														</td>
														<td width="10%" valign="top">
															<table border="0" cellpadding="0" cellspacing="0" width="100%">
																<xsl:for-each select="TaxesOutputs/Tax">
																	<tr>
																		<td width="100%" align="center">
																			<xsl:choose>
																				<xsl:when test='EquivalenceSurcharge!=""' >
																					<xsl:value-of select="EquivalenceSurcharge"/>
																				</xsl:when>
																				<xsl:otherwise>
																					-
																				</xsl:otherwise>
																			</xsl:choose>
																		</td>
																	</tr>
																</xsl:for-each>
															</table>
														</td>
														<td width="15%" valign="top">
															<table border="0" cellpadding="0" cellspacing="0" width="100%">
																<xsl:for-each select="TaxesOutputs/Tax">
																	<tr>
																		<td align="right">
																			<xsl:choose>
																				<xsl:when test='EquivalenceSurchargeAmount!=""' >
																					<xsl:value-of select="EquivalenceSurchargeAmount/TotalAmount"/>
																				</xsl:when>
																				<xsl:otherwise>
																					-
																				</xsl:otherwise>
																			</xsl:choose>
																		</td>
																	</tr>
																</xsl:for-each>
															</table>
														</td>
													</tr>
												</table>
											</xsl:when>
											<xsl:otherwise>
												<table border="1" cellpadding="0" cellspacing="0" width="100%">
													<tr>
														<td width="20%" align="center" rowspan="2">
															<font class="titulopeque">CLASE DE IMPUESTO</font>
														</td>
														<td width="7%" align="center" rowspan="2">
															<font class="titulopeque">TIPO (%)</font>
														</td>
														<xsl:choose>
															<xsl:when test='TaxesOutputs/Tax/SpecialTaxableBase!=""' >
																<td width="22%" valign="top" align="center" colspan="2">
																	<font class="titulopeque">BASE IMPONIBLE ESPECIAL</font>
																</td>
																<td width="22%" valign="top" align="center" colspan="2">
																	<font class="titulopeque">CUOTA ESPECIAL</font>
																</td>
															</xsl:when>
															<xsl:otherwise>
																<td width="22%" valign="top" align="center" colspan="2">
																	<font class="titulopeque">BASE IMPONIBLE</font>
																</td>
																<td width="22%" valign="top" align="center" colspan="2">
																	<font class="titulopeque">CUOTA</font>
																</td>
															</xsl:otherwise>
														</xsl:choose>
														<td width="7%" valign="top" align="center" rowspan="2">
															<font class="titulopeque">RECARGO EQUIV. (%)</font>
														</td>
														<td width="22%" valign="top" align="center" colspan="2">
															<font class="titulopeque">CUOTA RECARGO EQUIV.</font>
														</td>
													</tr>
													<tr>
														<td valign="top" align="center">
															<font class="titulopeque">Importe</font>
														</td>
														<td valign="top" align="center">
															<font class="titulopeque">Contravalor</font>
														</td>
														<td valign="top" align="center">
															<font class="titulopeque">Importe</font>
														</td>
														<td valign="top" align="center">
															<font class="titulopeque">Contravalor</font>
														</td>
														<td valign="top" align="center">
															<font class="titulopeque">Importe</font>
														</td>
														<td valign="top" align="center">
															<font class="titulopeque">Contravalor</font>
														</td>
													</tr>
													<tr>
														<td width="20%" valign="top">
															<table border="0" cellpadding="0" cellspacing="0" width="100%">
																<xsl:for-each select="TaxesOutputs/Tax">
																	<tr>
																		<td width="100%">
																			<script>
																				document.write(descTipoImpuesto('<xsl:value-of select="TaxTypeCode"/>'));
																			</script>
																		</td>
																	</tr>
																</xsl:for-each>
															</table>
														</td>
														<td width="7%" valign="top">
															<table border="0" cellpadding="0" cellspacing="0" width="100%">
																<xsl:for-each select="TaxesOutputs/Tax">
																	<tr>
																		<td width="100%" align="center">
																			<xsl:choose>
																				<xsl:when test='TaxRate!=""' >
																					<xsl:value-of select="TaxRate"/>
																				</xsl:when>
																				<xsl:otherwise>
																					-
																				</xsl:otherwise>
																			</xsl:choose>
																		</td>
																	</tr>
																</xsl:for-each>
															</table>
														</td>
														<td width="11%" valign="top">
															<table border="0" cellpadding="0" cellspacing="0" width="100%">
																<xsl:for-each select="TaxesOutputs/Tax">
																	<tr>
																		<td width="100%" align="right">
																			<xsl:choose>
																				<xsl:when test='SpecialTaxableBase!=""' >
																					<xsl:value-of select="SpecialTaxableBase/TotalAmount"/>
																				</xsl:when>
																				<xsl:otherwise>
																					<xsl:value-of select="TaxableBase/TotalAmount"/>
																				</xsl:otherwise>
																			</xsl:choose>
																		</td>
																	</tr>
																</xsl:for-each>
															</table>
														</td>
														<td width="11%" valign="top">
															<table border="0" cellpadding="0" cellspacing="0" width="100%">
																<xsl:for-each select="TaxesOutputs/Tax">
																	<tr>
																		<td width="100%" align="right">
																			<xsl:choose>
																				<xsl:when test='SpecialTaxableBase!=""' >
																					<xsl:value-of select="SpecialTaxableBase/EquivalentInEuros"/>
																				</xsl:when>
																				<xsl:otherwise>
																					<xsl:value-of select="TaxableBase/EquivalentInEuros"/>
																				</xsl:otherwise>
																			</xsl:choose>
																		</td>
																	</tr>
																</xsl:for-each>
															</table>
														</td>
														<td width="11%" valign="top">
															<table border="0" cellpadding="0" cellspacing="0" width="100%">
																<xsl:for-each select="TaxesOutputs/Tax">
																	<tr>
																		<td align="right">
																			<xsl:choose>
																				<xsl:when test='SpecialTaxAmount!=""' >
																					<xsl:value-of select="SpecialTaxAmount/TotalAmount"/>
																				</xsl:when>
																				<xsl:when test='TaxAmount!=""' >
																					<xsl:value-of select="TaxAmount/TotalAmount"/>
																				</xsl:when>
																				<xsl:otherwise>
																					-
																				</xsl:otherwise>
																			</xsl:choose>
																		</td>
																	</tr>
																</xsl:for-each>
															</table>
														</td>
														<td width="11%" valign="top">
															<table border="0" cellpadding="0" cellspacing="0" width="100%">
																<xsl:for-each select="TaxesOutputs/Tax">
																	<tr>
																		<td align="right">
																			<xsl:choose>
																				<xsl:when test='SpecialTaxAmount!=""' >
																					<xsl:value-of select="SpecialTaxAmount/EquivalentInEuros"/>
																				</xsl:when>
																				<xsl:when test='TaxAmount!=""' >
																					<xsl:value-of select="TaxAmount/EquivalentInEuros"/>
																				</xsl:when>
																				<xsl:otherwise>
																					-
																				</xsl:otherwise>
																			</xsl:choose>
																		</td>
																	</tr>
																</xsl:for-each>
															</table>
														</td>
														<td width="7%" valign="top">
															<table border="0" cellpadding="0" cellspacing="0" width="100%">
																<xsl:for-each select="TaxesOutputs/Tax">
																	<tr>
																		<td width="100%" align="center">
																			<xsl:choose>
																				<xsl:when test='EquivalenceSurcharge!=""' >
																					<xsl:value-of select="EquivalenceSurcharge"/>
																				</xsl:when>
																				<xsl:otherwise>
																					-
																				</xsl:otherwise>
																			</xsl:choose>
																		</td>
																	</tr>
																</xsl:for-each>
															</table>
														</td>
														<td width="11%" valign="top">
															<table border="0" cellpadding="0" cellspacing="0" width="100%">
																<xsl:for-each select="TaxesOutputs/Tax">
																	<tr>
																		<td align="right">
																			<xsl:choose>
																				<xsl:when test='EquivalenceSurchargeAmount/TotalAmount!=""' >
																					<xsl:value-of select="EquivalenceSurchargeAmount/TotalAmount"/>
																				</xsl:when>
																				<xsl:otherwise>
																					-
																				</xsl:otherwise>
																			</xsl:choose>
																		</td>
																	</tr>
																</xsl:for-each>
															</table>
														</td>
														<td width="11%" valign="top">
															<table border="0" cellpadding="0" cellspacing="0" width="100%">
																<xsl:for-each select="TaxesOutputs/Tax">
																	<tr>
																		<td align="right">
																			<xsl:choose>
																				<xsl:when test='EquivalenceSurchargeAmount/EquivalentInEuros!=""' >
																					<xsl:value-of select="EquivalenceSurchargeAmount/EquivalentInEuros"/>
																				</xsl:when>
																				<xsl:otherwise>
																					-
																				</xsl:otherwise>
																			</xsl:choose>
																		</td>
																	</tr>
																</xsl:for-each>
															</table>
														</td>
													</tr>
												</table>
											</xsl:otherwise>
										</xsl:choose>
									</td>
								</tr>
								<tr>
									<td>&#160;</td>
								</tr>
								<tr>
									<td width="100%">
										<table border="0" cellpadding="0" cellspacing="0" width="100%">
											<tr>
												<td width="80%" align="right">
													<font class="titulopeque">TOTAL IMPUESTOS REPERCUTIDOS&#160;&#160;&#160;&#160;&#160;</font>
												</td>
												<td width="20%" align="center">
													<table border="1" cellpadding="0" cellspacing="0" width="100%">
														<tr>
															<td align="right">
																<font class="titulopeque">
																	<xsl:value-of select="InvoiceTotals/TotalTaxOutputs"/>
																</font>
															</td>
														</tr>
													</table>
												</td>
											</tr>
										</table>
									</td>
								</tr>
								<tr>
									<td>&#160;</td>
								</tr>
								</xsl:if>
								<xsl:if test='TaxesWithheld!=""' >
								<tr>
									<td>
										<font class="titulopeque"><i>IMPUESTOS RETENIDOS</i></font>
										<xsl:choose>
											<xsl:when test='//m:Facturae/FileHeader/Batch/InvoiceCurrencyCode="EUR"'>
												<table border="1" cellpadding="0" cellspacing="0" width="100%">
													<tr>
														<td width="50%" valign="top" align="center">
															<font class="titulopeque">CLASE DE IMPUESTO</font>
														</td>
														<td width="10%" valign="top" align="center">
															<font class="titulopeque">TIPO (%)</font>
														</td>
														<td width="20%" valign="top" align="center">
															<font class="titulopeque">BASE IMPONIBLE</font>
														</td>
														<td width="20%" valign="top" align="center">
															<font class="titulopeque">CUOTA</font>
														</td>
													</tr>
													<tr>
														<td width="50%" valign="top">
															<table border="0" cellpadding="0" cellspacing="0" width="100%">
																<xsl:for-each select="TaxesWithheld/Tax">
																	<tr>
																		<td width="100%">
																			<script>
																				document.write(descTipoImpuesto('<xsl:value-of select="TaxTypeCode"/>'));
																			</script>
																		</td>
																	</tr>
																</xsl:for-each>
															</table>
														</td>
														<td width="10%" valign="top">
															<table border="0" cellpadding="0" cellspacing="0" width="100%">
																<xsl:for-each select="TaxesWithheld/Tax">
																	<tr>
																		<td width="100%" align="center">
																			<xsl:choose>
																				<xsl:when test='TaxRate!=""' >
																					<xsl:value-of select="TaxRate"/>
																				</xsl:when>
																				<xsl:otherwise>
																					-
																				</xsl:otherwise>
																			</xsl:choose>
																		</td>
																	</tr>
																</xsl:for-each>
															</table>
														</td>
														<td width="10%" valign="top">
															<table border="0" cellpadding="0" cellspacing="0" width="100%">
																<xsl:for-each select="TaxesWithheld/Tax">
																	<tr>
																		<td width="100%" align="right">
																			<xsl:choose>
																				<xsl:when test='TaxableBase!=""' >
																					<xsl:value-of select="TaxableBase/TotalAmount"/>
																				</xsl:when>
																				<xsl:otherwise>
																					-
																				</xsl:otherwise>
																			</xsl:choose>
																		</td>
																	</tr>
																</xsl:for-each>
															</table>
														</td>
														<td width="20%" valign="top">
															<table border="0" cellpadding="0" cellspacing="0" width="100%">
																<xsl:for-each select="TaxesWithheld/Tax">
																	<tr>
																		<td align="right">
																			<xsl:choose>
																				<xsl:when test='TaxAmount!=""' >
																					<xsl:value-of select="TaxAmount/TotalAmount"/>
																				</xsl:when>
																				<xsl:otherwise>
																					-
																				</xsl:otherwise>
																			</xsl:choose>
																		</td>
																	</tr>
																</xsl:for-each>
															</table>
														</td>
													</tr>
												</table>
											</xsl:when>
											<xsl:otherwise>
												<table border="1" cellpadding="0" cellspacing="0" width="100%">
													<tr>
														<td width="30%" align="center" rowspan="2">
															<font class="titulopeque">CLASE DE IMPUESTO</font>
														</td>
														<td width="10%" align="center" rowspan="2">
															<font class="titulopeque">TIPO (%)</font>
														</td>
														<td width="30%" valign="top" align="center" colspan="2">
															<font class="titulopeque">BASE IMPONIBLE</font>
														</td>
														<td width="30%" valign="top" align="center" colspan="2">
															<font class="titulopeque">CUOTA</font>
														</td>
													</tr>
													<tr>
														<td valign="top" align="center">
															<font class="titulopeque">Importe</font>
														</td>
														<td valign="top" align="center">
															<font class="titulopeque">Contravalor</font>
														</td>
														<td valign="top" align="center">
															<font class="titulopeque">Importe</font>
														</td>
														<td valign="top" align="center">
															<font class="titulopeque">Contravalor</font>
														</td>
													</tr>
													<tr>
														<td width="30%" valign="top">
															<table border="0" cellpadding="0" cellspacing="0" width="100%">
																<xsl:for-each select="TaxesWithheld/Tax">
																	<tr>
																		<td width="100%">
																			<script>
																				document.write(descTipoImpuesto('<xsl:value-of select="TaxTypeCode"/>'));
																			</script>
																		</td>
																	</tr>
																</xsl:for-each>
															</table>
														</td>
														<td width="10%" valign="top">
															<table border="0" cellpadding="0" cellspacing="0" width="100%">
																<xsl:for-each select="TaxesWithheld/Tax">
																	<tr>
																		<td width="100%" align="center">
																			<xsl:choose>
																				<xsl:when test='TaxRate!=""' >
																					<xsl:value-of select="TaxRate"/>
																				</xsl:when>
																				<xsl:otherwise>
																					-
																				</xsl:otherwise>
																			</xsl:choose>
																		</td>
																	</tr>
																</xsl:for-each>
															</table>
														</td>
														<td width="15%" valign="top">
															<table border="0" cellpadding="0" cellspacing="0" width="100%">
																<xsl:for-each select="TaxesWithheld/Tax">
																	<tr>
																		<td width="100%" align="right">
																			<xsl:choose>
																				<xsl:when test='TaxableBase/TotalAmount!=""' >
																					<xsl:value-of select="TaxableBase/TotalAmount"/>
																				</xsl:when>
																				<xsl:otherwise>
																					-
																				</xsl:otherwise>
																			</xsl:choose>
																		</td>
																	</tr>
																</xsl:for-each>
															</table>
														</td>
														<td width="15%" valign="top">
															<table border="0" cellpadding="0" cellspacing="0" width="100%">
																<xsl:for-each select="TaxesWithheld/Tax">
																	<tr>
																		<td width="100%" align="right">
																			<xsl:choose>
																				<xsl:when test='TaxableBase/EquivalentInEuros!=""' >
																					<xsl:value-of select="TaxableBase/EquivalentInEuros"/>
																				</xsl:when>
																				<xsl:otherwise>
																					-
																				</xsl:otherwise>
																			</xsl:choose>
																		</td>
																	</tr>
																</xsl:for-each>
															</table>
														</td>
														<td width="15%" valign="top">
															<table border="0" cellpadding="0" cellspacing="0" width="100%">
																<xsl:for-each select="TaxesWithheld/Tax">
																	<tr>
																		<td align="right">
																			<xsl:choose>
																				<xsl:when test='TaxAmount/TotalAmount!=""' >
																					<xsl:value-of select="TaxAmount/TotalAmount"/>
																				</xsl:when>
																				<xsl:otherwise>
																					-
																				</xsl:otherwise>
																			</xsl:choose>
																		</td>
																	</tr>
																</xsl:for-each>
															</table>
														</td>
														<td width="15%" valign="top">
															<table border="0" cellpadding="0" cellspacing="0" width="100%">
																<xsl:for-each select="TaxesWithheld/Tax">
																	<tr>
																		<td align="right">
																			<xsl:choose>
																				<xsl:when test='TaxAmount/EquivalentInEuros!=""' >
																					<xsl:value-of select="TaxAmount/EquivalentInEuros"/>
																				</xsl:when>
																				<xsl:otherwise>
																					-
																				</xsl:otherwise>
																			</xsl:choose>
																		</td>
																	</tr>
																</xsl:for-each>
															</table>
														</td>
													</tr>
												</table>
											</xsl:otherwise>
										</xsl:choose>
									</td>
								</tr>
								<tr>
									<td>&#160;</td>
								</tr>
								<tr>
									<td width="100%">
										<table border="0" cellpadding="0" cellspacing="0" width="100%">
											<tr>
												<td width="80%" align="right">
													<font class="titulopeque">TOTAL IMPUESTOS RETENIDOS&#160;&#160;&#160;&#160;&#160;</font>
												</td>
												<td width="20%" align="center">
													<table border="1" cellpadding="0" cellspacing="0" width="100%">
														<tr>
															<td align="right">
																<font class="titulopeque">
																	<xsl:value-of select="InvoiceTotals/TotalTaxesWithheld"/>
																</font>
															</td>
														</tr>
													</table>
												</td>
											</tr>
										</table>
									</td>
								</tr>
								<tr>
									<td>&#160;</td>
								</tr>
								</xsl:if>
								<tr>
									<td width="100%">
										<table border="0" cellpadding="0" cellspacing="0" width="100%">
											<tr>
												<td width="80%" align="right">
													<font class="titulopeque">TOTAL FACTURA&#160;&#160;&#160;&#160;&#160;</font>
												</td>
												<td width="20%" align="center">
													<table border="1" cellpadding="0" cellspacing="0" width="100%">
														<tr>
															<td align="right">
																<font class="titulopeque">
																	<xsl:value-of select="InvoiceTotals/InvoiceTotal"/>
																</font>
															</td>
														</tr>
													</table>
												</td>
											</tr>
										</table>
									</td>
								</tr>
								<tr>
									<td>&#160;</td>
								</tr>
								<xsl:if test='InvoiceTotals/Subsidies!=""' >
								<tr>
									<td>
										<font class="titulopeque"><i>SUBVENCIONES</i></font>
										<table border="1" cellpadding="0" cellspacing="0" width="100%">
											<tr>
												<td width="70%" valign="top" align="center">
													<font class="titulopeque">CONCEPTO</font>
												</td>
												<td width="10%" valign="top" align="center">
													<font class="titulopeque">TIPO (%)</font>
												</td>
												<td width="20%" valign="top" align="center">
													<font class="titulopeque">IMPORTE</font>
												</td>
											</tr>
											<tr>
												<td width="70%" valign="top">
													<table border="0" cellpadding="0" cellspacing="0" width="100%">
														<xsl:for-each select="InvoiceTotals/Subsidies/Subsidy">
															<tr>
																<td width="100%">
																	<xsl:apply-templates select="SubsidyDescription"/>
																</td>
															</tr>
														</xsl:for-each>
													</table>
												</td>
												<td width="10%" valign="top">
													<table border="0" cellpadding="0" cellspacing="0" width="100%">
														<xsl:for-each select="InvoiceTotals/Subsidies/Subsidy">
															<tr>
																<td width="100%" align="center">
																	<xsl:choose>
																		<xsl:when test='SubsidyRate!=""' >
																			<xsl:value-of select="SubsidyRate"/>
																		</xsl:when>
																		<xsl:otherwise>
																			-
																		</xsl:otherwise>
																	</xsl:choose>
																</td>
															</tr>
														</xsl:for-each>
													</table>
												</td>
												<td width="20%" valign="top">
													<table border="0" cellpadding="0" cellspacing="0" width="100%">
														<xsl:for-each select="InvoiceTotals/Subsidies/Subsidy">
															<tr>
																<td align="right">
																	<xsl:value-of select="SubsidyAmount"/>
																</td>
															</tr>
														</xsl:for-each>
													</table>
												</td>
											</tr>
										</table>
									</td>
								</tr>
								<tr>
									<td>&#160;</td>
								</tr>
								</xsl:if>
								<xsl:if test='InvoiceTotals/PaymentsOnAccount!=""' >
								<tr>
									<td align="right">
										<table border="0" cellpadding="0" cellspacing="0" width="40%">
											<tr>
												<td><font class="titulopeque"><i>ANTICIPOS</i></font></td>
											</tr>
										</table>
										<table border="1" cellpadding="0" cellspacing="0" width="40%">
											<tr>
												<td width="50%" valign="top" align="center">
													<font class="titulopeque">FECHA</font>
												</td>
												<td width="50%" valign="top" align="center">
													<font class="titulopeque">IMPORTE</font>
												</td>
											</tr>
											<tr>
												<td width="50%" valign="top">
													<table border="0" cellpadding="0" cellspacing="0" width="100%">
														<xsl:for-each select="InvoiceTotals/PaymentsOnAccount/PaymentOnAccount">
															<tr>
																<td width="100%" align="center">
																	<xsl:value-of select="substring(PaymentOnAccountDate,9,2)"/>-<xsl:value-of select="substring(PaymentOnAccountDate,6,2)"/>-<xsl:value-of select="substring(PaymentOnAccountDate,1,4)"/>
																</td>
															</tr>
														</xsl:for-each>
													</table>
												</td>
												<td width="50%" valign="top">
													<table border="0" cellpadding="0" cellspacing="0" width="100%">
														<xsl:for-each select="InvoiceTotals/PaymentsOnAccount/PaymentOnAccount">
															<tr>
																<td align="right">
																	<xsl:value-of select="PaymentOnAccountAmount"/>
																</td>
															</tr>
														</xsl:for-each>
													</table>
												</td>
											</tr>
										</table>
									</td>
								</tr>
								<tr>
									<td>&#160;</td>
								</tr>
								<tr>
									<td width="100%">
										<table border="0" cellpadding="0" cellspacing="0" width="100%">
											<tr>
												<td width="80%" align="right">
													<font class="titulopeque">TOTAL ANTICIPOS&#160;&#160;&#160;&#160;&#160;</font>
												</td>
												<td width="20%" align="center">
													<table border="1" cellpadding="0" cellspacing="0" width="100%">
														<tr>
															<td align="right">
																<font class="titulopeque">
																	<xsl:value-of select="InvoiceTotals/TotalPaymentsOnAccount"/>
																</font>
															</td>
														</tr>
													</table>
												</td>
											</tr>
										</table>
									</td>
								</tr>
								<tr>
									<td>&#160;</td>
								</tr>
								</xsl:if>
								<xsl:if test='InvoiceTotals/ReimbursableExpenses!=""' >
								<tr>
									<td align="right">
										<table border="0" cellpadding="0" cellspacing="0" width="100%">
											<tr>
												<td><font class="titulopeque"><i>SUPLIDOS</i></font></td>
											</tr>
										</table>
										<table border="1" cellpadding="0" cellspacing="0" width="100%">
											<tr>
												<td width="20%" valign="top" align="center">
													<font class="titulopeque">EMISOR</font>
												</td>
												<td width="20%" valign="top" align="center">
													<font class="titulopeque">RECEPTOR</font>
												</td>
												<td width="15%" valign="top" align="center">
													<font class="titulopeque">FECHA</font>
												</td>
												<td width="15%" valign="top" align="center">
													<font class="titulopeque">NÚMERO</font>
												</td>
												<td width="15%" valign="top" align="center">
													<font class="titulopeque">SERIE</font>
												</td>
												<td width="15%" valign="top" align="center">
													<font class="titulopeque">IMPORTE</font>
												</td>
											</tr>
											<xsl:for-each select="InvoiceTotals/ReimbursableExpenses/ReimbursableExpenses">
												<tr>
													<td width="20%" valign="top" align="center">
														<xsl:choose>
															<xsl:when test='ReimbursableExpensesSellerParty/PersonTypeCode!=""' >
																<script>
																	document.write(descTipoPersona('<xsl:value-of select="ReimbursableExpensesSellerParty/PersonTypeCode"/>'));
																</script>
																-
																<script>
																	document.write(descTipoResidencia('<xsl:value-of select="ReimbursableExpensesSellerParty/ResidenceTypeCode"/>'));
																</script>
																-
																<xsl:value-of select="ReimbursableExpensesSellerParty/TaxIdentificationNumber"/>
															</xsl:when>
															<xsl:otherwise>
																-
															</xsl:otherwise>
														</xsl:choose>
													</td>
													<td width="20%" valign="top" align="center">
														<xsl:choose>
															<xsl:when test='ReimbursableExpensesBuyerParty/PersonTypeCode!=""' >
																<script>
																	document.write(descTipoPersona('<xsl:value-of select="ReimbursableExpensesBuyerParty/PersonTypeCode"/>'));
																</script>
																-
																<script>
																	document.write(descTipoResidencia('<xsl:value-of select="ReimbursableExpensesBuyerParty/ResidenceTypeCode"/>'));
																</script>
																-
																<xsl:value-of select="ReimbursableExpensesBuyerParty/TaxIdentificationNumber"/>
															</xsl:when>
															<xsl:otherwise>
																-
															</xsl:otherwise>
														</xsl:choose>
													</td>
													<td width="15%" valign="top" align="center">
														<xsl:choose>
															<xsl:when test='IssueDate!=""' >
																<xsl:value-of select="substring(IssueDate,9,2)"/>-<xsl:value-of select="substring(IssueDate,6,2)"/>-<xsl:value-of select="substring(IssueDate,1,4)"/>
															</xsl:when>
															<xsl:otherwise>
																-
															</xsl:otherwise>
														</xsl:choose>
													</td>
													<td width="15%" valign="top" align="center">
														<xsl:choose>
															<xsl:when test='InvoiceNumber!=""' >
																<xsl:value-of select="InvoiceNumber"/>
															</xsl:when>
															<xsl:otherwise>
																-
															</xsl:otherwise>
														</xsl:choose>
													</td>
													<td width="15%" valign="top" align="center">
														<xsl:choose>
															<xsl:when test='InvoiceSeriesCode!=""' >
																<xsl:value-of select="InvoiceSeriesCode"/>
															</xsl:when>
															<xsl:otherwise>
																-
															</xsl:otherwise>
														</xsl:choose>
													</td>
													<td width="15%" valign="top" align="right">
														<xsl:value-of select="ReimbursableExpensesAmount"/>
													</td>
												</tr>
											</xsl:for-each>
										</table>
									</td>
								</tr>
								<tr>
									<td>&#160;</td>
								</tr>
								<tr>
									<td width="100%">
										<table border="0" cellpadding="0" cellspacing="0" width="100%">
											<tr>
												<td width="80%" align="right">
													<font class="titulopeque">TOTAL SUPLIDOS&#160;&#160;&#160;&#160;&#160;</font>
												</td>
												<td width="20%" align="center">
													<table border="1" cellpadding="0" cellspacing="0" width="100%">
														<tr>
															<td align="right">
																<font class="titulopeque">
																	<xsl:value-of select="InvoiceTotals/TotalReimbursableExpenses"/>
																</font>
															</td>
														</tr>
													</table>
												</td>
											</tr>
										</table>
									</td>
								</tr>
								<tr>
									<td>&#160;</td>
								</tr>
								</xsl:if>
								<xsl:if test='InvoiceTotals/TotalFinancialExpenses!=""' >
								<tr>
									<td width="100%">
										<table border="0" cellpadding="0" cellspacing="0" width="100%">
											<tr>
												<td width="80%" align="right">
													<font class="titulopeque">TOTAL GASTOS FINANCIEROS&#160;&#160;&#160;&#160;&#160;</font>
												</td>
												<td width="20%" align="center">
													<table border="1" cellpadding="0" cellspacing="0" width="100%">
														<tr>
															<td align="right">
																<font class="titulopeque">
																	<xsl:value-of select="InvoiceTotals/TotalFinancialExpenses"/>
																</font>
															</td>
														</tr>
													</table>
												</td>
											</tr>
										</table>
									</td>
								</tr>
								<tr>
									<td>&#160;</td>
								</tr>
								</xsl:if>
								<tr>
									<td width="100%">
										<table border="0" cellpadding="0" cellspacing="0" width="100%">
											<tr>
												<td width="80%" align="right">
													<font class="titulopeque">TOTAL A PAGAR&#160;&#160;&#160;&#160;&#160;</font>
												</td>
												<td width="20%" align="center">
													<table border="1" cellpadding="0" cellspacing="0" width="100%">
														<tr>
															<td align="right">
																<font class="titulopeque">
																	<xsl:value-of select="InvoiceTotals/TotalOutstandingAmount"/>
																</font>
															</td>
														</tr>
													</table>
												</td>
											</tr>
										</table>
									</td>
								</tr>
								<tr>
									<td>&#160;</td>
								</tr>
								<xsl:if test='InvoiceTotals/AmountsWithheld!=""' >
								<tr>
									<td>
										<font class="titulopeque"><i>RETENCIÓN GARANTÍA</i></font>
										<table border="1" cellpadding="0" cellspacing="0" width="100%">
											<tr>
												<td width="70%" valign="top" align="center">
													<font class="titulopeque">CONCEPTO</font>
												</td>
												<td width="10%" valign="top" align="center">
													<font class="titulopeque">TIPO (%)</font>
												</td>
												<td width="20%" valign="top" align="center">
													<font class="titulopeque">IMPORTE</font>
												</td>
											</tr>
											<tr>
												<td width="70%" valign="top">
													<xsl:apply-templates select="InvoiceTotals/AmountsWithheld/WithholdingReason"/>
												</td>
												<td width="10%" valign="top" align="center">
													<xsl:choose>
														<xsl:when test='InvoiceTotals/AmountsWithheld/WithholdingRate!=""' >
															<xsl:value-of select="InvoiceTotals/AmountsWithheld/WithholdingRate"/>
														</xsl:when>
														<xsl:otherwise>
															-
														</xsl:otherwise>
													</xsl:choose>
												</td>
												<td width="20%" valign="top" align="right">
													<xsl:value-of select="InvoiceTotals/AmountsWithheld/WithholdingAmount"/>
												</td>
											</tr>
										</table>
									</td>
								</tr>
								<tr>
									<td>&#160;</td>
								</tr>
								</xsl:if>
								<tr>
									<td width="100%">
										<table border="0" cellpadding="0" cellspacing="0" width="100%">
											<tr>
												<td width="80%" align="right">
													<font class="titulopeque">TOTAL A EJECUTAR&#160;&#160;&#160;&#160;&#160;</font>
												</td>
												<td width="20%" align="center">
													<table border="1" cellpadding="0" cellspacing="0" width="100%">
														<tr>
															<td align="right">
																<font class="titulopeque">
																	<xsl:value-of select="InvoiceTotals/TotalExecutableAmount"/>
																</font>
															</td>
														</tr>
													</table>
												</td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<xsl:apply-templates select="PaymentDetails"/>
					<xsl:apply-templates select="LegalLiterals"/>
					<xsl:apply-templates select="AdditionalData"/>
				</table>
			</td>
		</tr>
		<tr>
			<td>
				<xsl:apply-templates select="Items/InvoiceLine">
					<xsl:with-param name="nFactura" select="$numFactura"/>
				</xsl:apply-templates>
			</td>
		</tr>
	</xsl:template>
	<xsl:template match="//m:Facturae/Invoices/Invoice/InvoiceHeader/Corrective">
		<tr>
			<td>&#160;</td>
		</tr>
		<tr>
			<td>
				<hr/>
			</td>
		</tr>
		<tr>
			<td width="100%">
				<table border="0" cellpadding="0" cellspacing="0" width="100%">
					<tr>
						<td colspan="2">
							<font class="titulo2">FACTURA RECTIFICATIVA</font>
						</td>
					</tr>
					<tr>
						<td colspan="2">&#160;</td>
					</tr>
					<tr>
						<td width="50%">
							<font class="titulopeque">NUMERO:</font>
							&#160;&#160;&#160;
							<xsl:value-of select="InvoiceNumber"/><br/>
						</td>
						<xsl:if test='InvoiceSeriesCode!=""'>
							<td width="50%">
								<font class="titulopeque">SERIE:</font>
								&#160;&#160;&#160;
								<xsl:value-of select="InvoiceSeriesCode"/><br/>
							</td>
					</xsl:if>
					</tr>
					<tr>
						<td width="50%">
							<font class="titulopeque">MOTIVO:</font>
							&#160;&#160;&#160;
							<xsl:value-of select="ReasonCode"/> - <xsl:value-of select="ReasonDescription"/>
						</td>
						<td width="50%">
							<font class="titulopeque">CRITERIO RECTIFICACIÓN:</font>
							&#160;&#160;&#160;
							<xsl:value-of select="CorrectionMethod"/> - <xsl:value-of select="CorrectionMethodDescription"/>
						</td>
					</tr>
					<tr>
						<td valign="top" colspan="2">
							<font class="titulopeque">PERIODO IMPOSITIVO:</font>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<table border="0" cellpadding="0" cellspacing="0" width="100%">
								<tr>
									<td width="50%">
										<font class="titulopeque">Fecha inicio:</font>&#160;&#160;&#160;
										<xsl:value-of select="substring(TaxPeriod/StartDate,9,2)"/>-<xsl:value-of select="substring(TaxPeriod/StartDate,6,2)"/>-<xsl:value-of select="substring(TaxPeriod/StartDate,1,4)"/>
									</td>
									<td width="50%">
										<font class="titulopeque">Fecha fin:</font>&#160;&#160;&#160;
										<xsl:value-of select="substring(TaxPeriod/EndDate,9,2)"/>-<xsl:value-of select="substring(TaxPeriod/EndDate,6,2)"/>-<xsl:value-of select="substring(TaxPeriod/EndDate,1,4)"/>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<xsl:if test='AdditionalReasonDescription!=""'>
						<tr>
							<td width="100%" colspan="2">
								<font class="titulopeque">AMPLIACIÓN MOTIVO DE LA RECTIFICACIÓN:</font>
								&#160;&#160;&#160;
								<xsl:value-of select="AdditionalReasonDescription"/><br/>
							</td>
						</tr>
					</xsl:if>
				</table>
			</td>
		</tr>
	</xsl:template>
	<xsl:template match="//m:Facturae/Invoices/Invoice/PaymentDetails">
		<tr>
			<td>&#160;</td>
		</tr>
		<tr>
			<td>
				<hr/>
			</td>
		</tr>
		<tr>
			<td>
				<font class="titulo2">DATOS DE PAGO</font>
			</td>
		</tr>
		<tr>
			<td>&#160;</td>
		</tr>
		<tr>
			<td width="100%">
				<table border="1" cellpadding="0" cellspacing="0" width="100%">
					<tr>
						<td width="7%" align="center">
							<font class="titulopeque">FECHA VENC.</font>
						</td>
						<td width="6%" align="center">
							<font class="titulopeque">IMPORTE</font>
						</td>
						<td width="10%" align="center">
							<font class="titulopeque">FORMA DE PAGO</font>
						</td>
						<td width="26%" align="center">
							<font class="titulopeque">CUENTA</font>
						</td>
						<td width="10%" align="center">
							<font class="titulopeque">REFERENCIA</font>
						</td>
						<td width="11%" align="center">
							<font class="titulopeque">REFERENCIA DÉBITO</font>
						</td>
						<td width="8%" align="center">
							<font class="titulopeque">CÓD. ESTADÍSTICO</font>
						</td>
						<td width="22%" align="center">
							<font class="titulopeque">OBSERVACIONES</font>
						</td>
					</tr>
					<xsl:for-each select="Installment">
						<tr>
							<td width="7%" valign="top" align="center">
								<xsl:value-of select="substring(InstallmentDueDate,9,2)"/>-<xsl:value-of select="substring(InstallmentDueDate,6,2)"/>-<xsl:value-of select="substring(InstallmentDueDate,1,4)"/>
							</td>
							<td width="6%" valign="top" align="right">
								<xsl:value-of select="InstallmentAmount"/>
							</td>
							<td width="10%" valign="top"  align="center">
								<script>
									document.write(descFormaPago('<xsl:value-of select="PaymentMeans"/>'));
								</script>
							</td>
							<td width="26%" valign="top"  align="center">
								<xsl:choose>
									<xsl:when test='AccountToBeCredited!=""' >
										<table border="0" cellpadding="0" cellspacing="0" width="95%" align="center">
											<xsl:if test='AccountToBeCredited/IBAN!=""' >
												<tr>
													<td width="30%">
														IBAN:
													</td>
													<td width="70%">
														<xsl:apply-templates select="AccountToBeCredited/IBAN"/>
													</td>
												</tr>
											</xsl:if>
											<xsl:if test='AccountToBeCredited/AccountNumber!=""' >
												<tr>
													<td width="30%">
														Núm. cuenta:
													</td>
													<td width="70%">
														<xsl:apply-templates select="AccountToBeCredited/AccountNumber"/>
													</td>
												</tr>
											</xsl:if>
											<xsl:if test='AccountToBeCredited/BankCode!=""' >
												<tr>
													<td>
														Entidad:
													</td>
													<td>
														<xsl:apply-templates select="AccountToBeCredited/BankCode"/>
													</td>
												</tr>
											</xsl:if>
											<xsl:if test='AccountToBeCredited/BranchCode!=""' >
												<tr>
													<td>
														Oficina:
													</td>
													<td>
														<xsl:apply-templates select="AccountToBeCredited/BranchCode"/>
													</td>
												</tr>
											</xsl:if>
											<tr>
												<td width="30%">
													SWIFT:
												</td>
												<td width="70%">
													<xsl:apply-templates select="AccountToBeCredited/BIC"/>
												</td>
											</tr>
											<xsl:if test='AccountToBeCredited/BranchInSpainAddress!=""' >
												<tr>
													<td valign="top">
														Dirección:
													</td>
													<td>
														<xsl:value-of select="AccountToBeCredited/BranchInSpainAddress/Address"/><br/>
														<xsl:value-of select="AccountToBeCredited/BranchInSpainAddress/PostCode"/>&#160;&#160;&#160;
														<xsl:value-of select="AccountToBeCredited/BranchInSpainAddress/Town"/><br/>
														<xsl:value-of select="AccountToBeCredited/BranchInSpainAddress/Province"/><br/>
														<xsl:value-of select="AccountToBeCredited/BranchInSpainAddress/CountryCode"/>
													</td>
												</tr>
											</xsl:if>
											<xsl:if test='AccountToBeCredited/OverseasBranchAddress!=""' >
												<tr>
													<td valign="top">
														Dirección:
													</td>
													<td>
														<xsl:value-of select="AccountToBeCredited/OverseasBranchAddress/Address"/><br/>
														<xsl:value-of select="AccountToBeCredited/OverseasBranchAddress/PostCodeAndTown"/><br/>
														<xsl:value-of select="AccountToBeCredited/OverseasBranchAddress/Province"/><br/>
														<xsl:value-of select="AccountToBeCredited/OverseasBranchAddress/CountryCode"/>
													</td>
												</tr>
											</xsl:if>
										</table>
									</xsl:when>
									<xsl:when test='AccountToBeDebited!=""' >
										<table border="0" cellpadding="0" cellspacing="0" width="95%" align="center">
											<xsl:if test='AccountToBeDebited/IBAN!=""' >
												<tr>
													<td width="30%">
														IBAN:
													</td>
													<td width="70%">
														<xsl:apply-templates select="AccountToBeDebited/IBAN"/>
													</td>
												</tr>
											</xsl:if>
											<xsl:if test='AccountToBeDebited/AccountNumber!=""' >
												<tr>
													<td width="30%">
														Núm. cuenta:
													</td>
													<td width="70%">
														<xsl:apply-templates select="AccountToBeDebited/AccountNumber"/>
													</td>
												</tr>
											</xsl:if>
											<xsl:if test='AccountToBeDebited/BankCode!=""' >
												<tr>
													<td>
														Entidad:
													</td>
													<td>
														<xsl:apply-templates select="AccountToBeDebited/BankCode"/>
													</td>
												</tr>
											</xsl:if>
											<xsl:if test='AccountToBeDebited/BranchCode!=""' >
												<tr>
													<td>
														Oficina:
													</td>
													<td>
														<xsl:apply-templates select="AccountToBeDebited/BranchCode"/>
													</td>
												</tr>
											</xsl:if>
											<tr>
												<td width="30%">
													SWIFT:
												</td>
												<td width="70%">
													<xsl:apply-templates select="AccountToBeDebited/BIC"/>
												</td>
											</tr>
											<xsl:if test='AccountToBeDebited/BranchInSpainAddress!=""' >
												<tr>
													<td valign="top">
														Dirección:
													</td>
													<td>
														<xsl:value-of select="AccountToBeDebited/BranchInSpainAddress/Address"/><br/>
														<xsl:value-of select="AccountToBeDebited/BranchInSpainAddress/PostCode"/>&#160;&#160;&#160;
														<xsl:value-of select="AccountToBeDebited/BranchInSpainAddress/Town"/><br/>
														<xsl:value-of select="AccountToBeDebited/BranchInSpainAddress/Province"/><br/>
														<xsl:value-of select="AccountToBeDebited/BranchInSpainAddress/CountryCode"/>
													</td>
												</tr>
											</xsl:if>
											<xsl:if test='AccountToBeDebited/OverseasBranchAddress!=""' >
												<tr>
													<td valign="top">
														Dirección:
													</td>
													<td>
														<xsl:value-of select="AccountToBeDebited/OverseasBranchAddress/Address"/><br/>
														<xsl:value-of select="AccountToBeDebited/OverseasBranchAddress/PostCodeAndTown"/><br/>
														<xsl:value-of select="AccountToBeDebited/OverseasBranchAddress/Province"/><br/>
														<xsl:value-of select="AccountToBeDebited/OverseasBranchAddress/CountryCode"/>
													</td>
												</tr>
											</xsl:if>
										</table>
									</xsl:when>
									<xsl:otherwise>
										&#160;
									</xsl:otherwise>
								</xsl:choose>
							</td>
							<td width="10%" valign="top">
								<xsl:choose>
									<xsl:when test='PaymentReconciliationReference!=""' >
										<xsl:apply-templates select="PaymentReconciliationReference"/>
									</xsl:when>
									<xsl:otherwise>
										&#160;
									</xsl:otherwise>
								</xsl:choose>
							</td>
							<td width="11%" valign="top">
								<xsl:choose>
									<xsl:when test='DebitReconciliationReference!=""' >
										<xsl:apply-templates select="DebitReconciliationReference"/>
									</xsl:when>
									<xsl:otherwise>
										&#160;
									</xsl:otherwise>
								</xsl:choose>
							</td>
							<td width="8%" valign="top">
								<xsl:choose>
									<xsl:when test='RegulatoryReportingData!=""' >
										<xsl:apply-templates select="RegulatoryReportingData"/>
									</xsl:when>
									<xsl:otherwise>
										&#160;
									</xsl:otherwise>
								</xsl:choose>
							</td>
							<td width="22%" valign="top">
								<xsl:choose>
									<xsl:when test='CollectionAdditionalInformation!=""' >
										<xsl:apply-templates select="CollectionAdditionalInformation"/>
									</xsl:when>
									<xsl:otherwise>
										&#160;
									</xsl:otherwise>
								</xsl:choose>
							</td>
						</tr>
					</xsl:for-each>
				</table>
			</td>
		</tr>
	</xsl:template>
	<xsl:template match="//m:Facturae/Invoices/Invoice/LegalLiterals">
		<tr>
			<td>&#160;</td>
		</tr>
		<tr>
			<td>
				<hr/>
			</td>
		</tr>
		<tr>
			<td>
				<font class="titulo2">LITERALES LEGALES</font>
			</td>
		</tr>
		<tr>
			<td>&#160;</td>
		</tr>
		<tr>
			<td width="100%">
				<table border="1" cellpadding="0" cellspacing="0" width="50%">
					<tr>
						<td align="center">
							<font class="titulopeque">MENCIÓN</font>
						</td>
					</tr>
					<xsl:for-each select="LegalReference">
						<tr>
							<td align="center">
								<xsl:value-of select="."/>
							</td>
						</tr>
					</xsl:for-each>
				</table>
			</td>
		</tr>
	</xsl:template>
	<xsl:template match="//m:Facturae/Invoices/Invoice/AdditionalData">
		<tr>
			<td>&#160;</td>
		</tr>
		<tr>
			<td>
				<hr/>
			</td>
		</tr>
		<tr>
			<td width="100%">
				<table border="0" cellpadding="0" cellspacing="0" width="100%">
					<tr>
						<td colspan="2">
							<font class="titulo2">DATOS ADICIONALES</font>
						</td>
					</tr>
					<tr>
						<td colspan="2">&#160;</td>
					</tr>
					<xsl:if test='RelatedInvoice!=""'>
						<tr>
							<td width="50%" colspan="2">
								<font class="titulopeque">FACTURA ASOCIADA:</font>
								&#160;&#160;&#160;
								<xsl:value-of select="RelatedInvoice"/><br/>
							</td>
						</tr>
					</xsl:if>
					<xsl:if test='InvoiceAdditionalInformation!=""'>
						<tr>
							<td width="50%" colspan="2">
								<font class="titulopeque">OBSERVACIONES:</font>
								&#160;&#160;&#160;
								<xsl:apply-templates select="InvoiceAdditionalInformation"/>
							</td>
						</tr>
					</xsl:if>
					<xsl:if test='RelatedDocuments!=""'>
						<tr>
							<td colspan="2">
								<font class="titulopeque">DOCUMENTOS RELACIONADOS</font>
								<table border="1" cellpadding="0" cellspacing="0" width="100%">
									<tr>
										<td width="10%" valign="top" align="center">
											<font class="titulopeque">COMPRESIÓN</font>
										</td>
										<td width="10%" valign="top" align="center">
											<font class="titulopeque">FORMATO</font>
										</td>
										<td width="10%" valign="top" align="center">
											<font class="titulopeque">ENCODING</font>
										</td>
										<td width="35%" valign="top" align="center">
											<font class="titulopeque">DESCRIPCIÓN</font>
										</td>
										<td width="35%" valign="top" align="center">
											<font class="titulopeque">DATOS</font>
										</td>
									</tr>
									<tr>
										<td width="10%" valign="top">
											<table border="0" cellpadding="0" cellspacing="0" width="100%">
												<xsl:for-each select="RelatedDocuments/Attachment">
													<tr>
														<td width="100%">
															<xsl:choose>
																<xsl:when test='AttachmentCompressionAlgorithm!=""' >
																	<xsl:apply-templates select="AttachmentCompressionAlgorithm"/>
																</xsl:when>
																<xsl:otherwise>
																	-
																</xsl:otherwise>
															</xsl:choose>
														</td>
													</tr>
												</xsl:for-each>
											</table>
										</td>
										<td width="10%" valign="top">
											<table border="0" cellpadding="0" cellspacing="0" width="100%">
												<xsl:for-each select="RelatedDocuments/Attachment">
													<tr>
														<td width="100%">
															<xsl:choose>
																<xsl:when test='AttachmentFormat!=""' >
																	<xsl:apply-templates select="AttachmentFormat"/>
																</xsl:when>
																<xsl:otherwise>
																	-
																</xsl:otherwise>
															</xsl:choose>
														</td>
													</tr>
												</xsl:for-each>
											</table>
										</td>
										<td width="10%" valign="top">
											<table border="0" cellpadding="0" cellspacing="0" width="100%">
												<xsl:for-each select="RelatedDocuments/Attachment">
													<tr>
														<td width="100%">
															<xsl:choose>
																<xsl:when test='AttachmentEncoding!=""' >
																	<xsl:apply-templates select="AttachmentEncoding"/>
																</xsl:when>
																<xsl:otherwise>
																	-
																</xsl:otherwise>
															</xsl:choose>
														</td>
													</tr>
												</xsl:for-each>
											</table>
										</td>
										<td width="35%" valign="top">
											<table border="0" cellpadding="0" cellspacing="0" width="100%">
												<xsl:for-each select="RelatedDocuments/Attachment">
													<tr>
														<td width="100%">
															<xsl:choose>
																<xsl:when test='AttachmentDescription!=""' >
																	<xsl:apply-templates select="AttachmentDescription"/>
																</xsl:when>
																<xsl:otherwise>
																	-
																</xsl:otherwise>
															</xsl:choose>
														</td>
													</tr>
												</xsl:for-each>
											</table>
										</td>
										<td width="35%" valign="top">
											<table border="0" cellpadding="0" cellspacing="0" width="100%">
												<xsl:for-each select="RelatedDocuments/Attachment">
													<tr>
														<td width="100%">
															<xsl:choose>
																<xsl:when test='AttachmentData!=""' >
																	<xsl:apply-templates select="AttachmentData"/>
																</xsl:when>
																<xsl:otherwise>
																	-
																</xsl:otherwise>
															</xsl:choose>
														</td>
													</tr>
												</xsl:for-each>
											</table>
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</xsl:if>
				</table>
			</td>
		</tr>
	</xsl:template>
	<xsl:template match="//m:Facturae/Invoices/Invoice/Items/InvoiceLine">
		<xsl:param name="nFactura"/>
		<table width="100%">
		<tr id="{$nFactura}_{ItemDescription}" style="">
			<td width="100%">
				<table border="0" cellpadding="0" cellspacing="0" width="100%">
					<tr>
						<td align="center" colspan="2">
							<font class="titulo1"><xsl:value-of select="ItemDescription"/></font>
						</td>
					</tr>
					<tr>
						<td align="right">

						</td>
					</tr>
					<tr>
						<td colspan="3">&#160;</td>
					</tr>
					<tr>
						<td width="100%">
							<table border="1" cellpadding="0" cellspacing="0" width="100%">
								<tr>
									<td>
										<table border="0" cellpadding="0" cellspacing="0" width="100%">
											<tr>
												<td align="center" width="33%">
													<font class="titulopeque">NÚMERO DE SECUENCIA</font>
													<br/>
													<xsl:choose>
														<xsl:when test='SequenceNumber!=""' >
															<xsl:value-of select="SequenceNumber"/>
														</xsl:when>
														<xsl:otherwise>
															-
														</xsl:otherwise>
													</xsl:choose>
												</td>
												<td align="center" width="33%">
													<font class="titulopeque">CANTIDAD</font>
													<br/><xsl:value-of select="Quantity"/>
												</td>
												<td align="center" width="33%">
													<font class="titulopeque">UNIDAD DE MEDIDA</font>
													<br/>
													<xsl:choose>
														<xsl:when test='UnitOfMeasure!=""' >
															<script>
																document.write(descUnidadMedida('<xsl:value-of select="UnitOfMeasure"/>'));
															</script>
														</xsl:when>
														<xsl:otherwise>
															-
														</xsl:otherwise>
													</xsl:choose>
												</td>
											</tr>
										</table>
									</td>
								</tr>
								<xsl:if test='ArticleCode!="" or LineItemPeriod!="" or TransactionDate!=""'>
									<tr>
										<td>
											<table border="0" cellpadding="0" cellspacing="0" width="100%">
												<tr>
													<td align="center" width="33%">
														<font class="titulopeque">CÓDIGO ARTÍCULO</font><br/>
														<xsl:choose>
															<xsl:when test='ArticleCode!=""' >
																<xsl:value-of select="ArticleCode"/>
															</xsl:when>
															<xsl:otherwise>
																-
															</xsl:otherwise>
														</xsl:choose>
													</td>
													<td align="center" width="33%">
														<font class="titulopeque">PERÍODO DETALLE</font><br/>
														<xsl:choose>
															<xsl:when test='LineItemPeriod!=""' >
																<xsl:value-of select="substring(LineItemPeriod/StartDate,9,2)"/>-<xsl:value-of select="substring(LineItemPeriod/StartDate,6,2)"/>-<xsl:value-of select="substring(LineItemPeriod/StartDate,1,4)"/> -
																<xsl:value-of select="substring(LineItemPeriod/EndDate,9,2)"/>-<xsl:value-of select="substring(LineItemPeriod/EndDate,6,2)"/>-<xsl:value-of select="substring(LineItemPeriod/EndDate,1,4)"/>
															</xsl:when>
															<xsl:otherwise>
																-
															</xsl:otherwise>
														</xsl:choose>
													</td>
													<td align="center" width="33%">
														<font class="titulopeque">FECHA OPERACIÓN</font>
														<br/>
														<xsl:choose>
															<xsl:when test='TransactionDate!=""' >
																<xsl:value-of select="substring(TransactionDate,9,2)"/>-<xsl:value-of select="substring(TransactionDate,6,2)"/>-<xsl:value-of select="substring(TransactionDate,1,4)"/>
														</xsl:when>
															<xsl:otherwise>
																-
															</xsl:otherwise>
														</xsl:choose>
													</td>
												</tr>
											</table>
										</td>
									</tr>
								</xsl:if>
								<xsl:if test='IssuerContractReference!="" or IssuerContractDate!=""'>
									<tr>
										<td>
											<table border="0" cellpadding="0" cellspacing="0" width="100%">
												<tr>
													<td align="center" width="50%">
														<font class="titulopeque">EXPEDIENTE CONTRATACIÓN EMISOR</font>
														<br/>
														<xsl:choose>
															<xsl:when test='IssuerContractReference!=""' >
																<xsl:value-of select="IssuerContractReference"/>
															</xsl:when>
															<xsl:otherwise>
																-
															</xsl:otherwise>
														</xsl:choose>
													</td>
													<td align="center" width="50%">
														<font class="titulopeque">FECHA CONTRATACIÓN EMISOR</font>
														<br/>
														<xsl:choose>
															<xsl:when test='IssuerContractDate!=""' >
																<xsl:value-of select="substring(IssuerContractDate,9,2)"/>-<xsl:value-of select="substring(IssuerContractDate,6,2)"/>-<xsl:value-of select="substring(IssuerContractDate,1,4)"/>
															</xsl:when>
															<xsl:otherwise>
																-
															</xsl:otherwise>
														</xsl:choose>
													</td>
												</tr>
											</table>
										</td>
									</tr>
								</xsl:if>
								<xsl:if test='IssuerTransactionReference!="" or IssuerTransactionDate!=""'>
									<tr>
										<td>
											<table border="0" cellpadding="0" cellspacing="0" width="100%">
												<tr>
													<td align="center" width="50%">
														<font class="titulopeque">REFERENCIA OPERACIÓN/PEDIDO EMISOR</font>
														<br/>
														<xsl:choose>
															<xsl:when test='IssuerTransactionReference!=""' >
																<xsl:value-of select="IssuerTransactionReference"/>
															</xsl:when>
															<xsl:otherwise>
																-
															</xsl:otherwise>
														</xsl:choose>
													</td>
													<td align="center" width="50%">
														<font class="titulopeque">FECHA OPERACIÓN/PEDIDO EMISOR</font>
														<br/>
														<xsl:choose>
															<xsl:when test='IssuerTransactionDate!=""' >
																<xsl:value-of select="substring(IssuerTransactionDate,9,2)"/>-<xsl:value-of select="substring(IssuerTransactionDate,6,2)"/>-<xsl:value-of select="substring(IssuerTransactionDate,1,4)"/>
															</xsl:when>
															<xsl:otherwise>
																-
															</xsl:otherwise>
														</xsl:choose>
													</td>
												</tr>
											</table>
										</td>
									</tr>
								</xsl:if>
								<xsl:if test='ReceiverContractReference!="" or BuyerPartyContractDate!=""'>
									<tr>
										<td>
											<table border="0" cellpadding="0" cellspacing="0" width="100%">
												<tr>
													<td align="center" width="50%">
														<font class="titulopeque">EXPEDIENTE CONTRATACIÓN RECEPTOR</font>
														<br/>
														<xsl:choose>
															<xsl:when test='ReceiverContractReference!=""' >
																<xsl:value-of select="ReceiverContractReference"/>
															</xsl:when>
															<xsl:otherwise>
																-
															</xsl:otherwise>
														</xsl:choose>
													</td>
													<td align="center" width="50%">
															<font class="titulopeque">FECHA CONTRATACIÓN RECEPTOR</font>
															<br/>
															<xsl:choose>
																<xsl:when test='BuyerPartyContractDate!=""' >
																	<xsl:value-of select="substring(BuyerPartyContractDate,9,2)"/>-<xsl:value-of select="substring(BuyerPartyContractDate,6,2)"/>-<xsl:value-of select="substring(BuyerPartyContractDate,1,4)"/>
																</xsl:when>
																<xsl:otherwise>
																	-
																</xsl:otherwise>
															</xsl:choose>
														</td>
												</tr>
											</table>
										</td>
									</tr>
								</xsl:if>
								<xsl:if test='ReceiverTransactionReference!="" or BuyerPartyTransactionDate!=""'>
									<tr>
										<td>
											<table border="0" cellpadding="0" cellspacing="0" width="100%">
												<tr>
													<td align="center" width="50%">
													<font class="titulopeque">REFERENCIA OPERACIÓN/PEDIDO RECEPTOR</font>
													<br/>
													<xsl:choose>
														<xsl:when test='ReceiverTransactionReference!=""' >
															<xsl:value-of select="ReceiverTransactionReference"/>
														</xsl:when>
														<xsl:otherwise>
															-
														</xsl:otherwise>
													</xsl:choose>
												</td>
													<td align="center" width="50%">
														<font class="titulopeque">FECHA OPERACIÓN/PEDIDO RECEPTOR</font>
														<br/>
														<xsl:choose>
															<xsl:when test='BuyerPartyTransactionDate!=""' >
																<xsl:value-of select="substring(BuyerPartyTransactionDate,9,2)"/>-<xsl:value-of select="substring(BuyerPartyTransactionDate,6,2)"/>-<xsl:value-of select="substring(BuyerPartyTransactionDate,1,4)"/>
															</xsl:when>
															<xsl:otherwise>
																-
															</xsl:otherwise>
														</xsl:choose>
													</td>
												</tr>
											</table>
										</td>
									</tr>
								</xsl:if>
								<xsl:if test='FileReference!="" or FileDate!=""'>
									<tr>
										<td>
											<table border="0" cellpadding="0" cellspacing="0" width="100%">
												<tr>
													<td align="center" width="50%">
														<font class="titulopeque">REFERENCIA EXPEDIENTE</font>
														<br/>
														<xsl:choose>
															<xsl:when test='FileReference!=""' >
																<xsl:value-of select="FileReference"/>
															</xsl:when>
															<xsl:otherwise>
																-
															</xsl:otherwise>
														</xsl:choose>
													</td>
													<td align="center" width="50%">
														<font class="titulopeque">FECHA EXPEDIENTE</font>
														<br/>
														<xsl:choose>
															<xsl:when test='FileDate!=""' >
																<xsl:value-of select="substring(FileDate,9,2)"/>-<xsl:value-of select="substring(FileDate,6,2)"/>-<xsl:value-of select="substring(FileDate,1,4)"/>
															</xsl:when>
															<xsl:otherwise>
																-
															</xsl:otherwise>
														</xsl:choose>
													</td>
												</tr>
											</table>
										</td>
									</tr>
								</xsl:if>
								<xsl:if test='SpecialTaxableEvent!=""' >
									<tr>
										<td>
											<table border="0" cellpadding="0" cellspacing="0" width="100%">
												<tr>
													<td align="center" width="50%">
														<font class="titulopeque">CÓDIGO FISCALIDAD ESPECIAL</font><br/>
														<xsl:choose>
															<xsl:when test='SpecialTaxableEvent/SpecialTaxableEventCode="01"' >
																Operación sujeta y exenta
															</xsl:when>
															<xsl:when test='SpecialTaxableEvent/SpecialTaxableEventCode="02"' >
																Operación no sujeta
															</xsl:when>
															<xsl:otherwise>
																<xsl:value-of select="SpecialTaxableEvent/SpecialTaxableEventCode"/>
															</xsl:otherwise>
														</xsl:choose>
													</td>
													<td align="center" width="50%">
														<font class="titulopeque">JUSTIFICACIÓN FISCALIDAD ESPECIAL</font>
														<br/>
														<xsl:value-of select="SpecialTaxableEvent/SpecialTaxableEventReason"/>
													</td>
												</tr>
											</table>
										</td>
									</tr>
								</xsl:if>
							</table>
						</td>
					</tr>
					<xsl:apply-templates select="DeliveryNotesReferences"/>
					<tr>
						<td>&#160;</td>
					</tr>
					<tr>
						<td>
							<hr/>
						</td>
					</tr>
					<tr>
						<td>
							<font class="titulo2">IMPORTES</font>
						</td>
					</tr>
					<tr>
						<td>&#160;</td>
					</tr>
					<tr>
						<td width="100%">
							<table border="0" cellpadding="0" cellspacing="0" width="100%">
								<tr>
									<td width="80%" align="right">
										<font class="titulopeque">PRECIO UNITARIO SIN IMPUESTOS&#160;&#160;&#160;&#160;&#160;</font>
									</td>
									<td width="20%" align="center">
										<table border="1" cellpadding="0" cellspacing="0" width="100%">
											<tr>
												<td align="right">
													<font class="titulopeque">
														<xsl:value-of select="UnitPriceWithoutTax"/>
													</font>
												</td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td>&#160;</td>
					</tr>
					<tr>
						<td width="100%">
							<table border="0" cellpadding="0" cellspacing="0" width="100%">
								<tr>
									<td width="80%" align="right">
										<font class="titulopeque">COSTE TOTAL&#160;&#160;&#160;&#160;&#160;</font>
									</td>
									<td width="20%" align="center">
										<table border="1" cellpadding="0" cellspacing="0" width="100%">
											<tr>
												<td align="right">
													<font class="titulopeque">
														<xsl:value-of select="TotalCost"/>
													</font>
												</td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td>&#160;</td>
					</tr>
					<xsl:if test='DiscountsAndRebates!=""' >
					<tr>
						<td>
							<font class="titulopeque"><i>DESCUENTOS</i></font>
							<table border="1" cellpadding="0" cellspacing="0" width="100%">
								<tr>
									<td width="70%" valign="top" align="center">
										<font class="titulopeque">CONCEPTO</font>
									</td>
									<td width="10%" valign="top" align="center">
										<font class="titulopeque">TIPO (%)</font>
									</td>
									<td width="20%" valign="top" align="center">
										<font class="titulopeque">IMPORTE</font>
									</td>
								</tr>
								<tr>
									<td width="70%" valign="top">
										<table border="0" cellpadding="0" cellspacing="0" width="100%">
											<xsl:for-each select="DiscountsAndRebates/Discount">
												<tr>
													<td width="100%">
														<xsl:apply-templates select="DiscountReason"/>
													</td>
												</tr>
											</xsl:for-each>
										</table>
									</td>
									<td width="10%" valign="top">
										<table border="0" cellpadding="0" cellspacing="0" width="100%">
											<xsl:for-each select="DiscountsAndRebates/Discount">
												<tr>
													<td width="100%" align="center">
														<xsl:choose>
															<xsl:when test='DiscountRate!=""' >
																<xsl:value-of select="DiscountRate"/>
															</xsl:when>
															<xsl:otherwise>
																-
															</xsl:otherwise>
														</xsl:choose>
													</td>
												</tr>
											</xsl:for-each>
										</table>
									</td>
									<td width="20%" valign="top">
										<table border="0" cellpadding="0" cellspacing="0" width="100%">
											<xsl:for-each select="DiscountsAndRebates/Discount">
												<tr>
													<td align="right">
														<xsl:value-of select="DiscountAmount"/>
													</td>
												</tr>
											</xsl:for-each>
										</table>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td>&#160;</td>
					</tr>
					</xsl:if>
					<xsl:if test='Charges!=""' >
					<tr>
						<td>
							<font class="titulopeque"><i>CARGOS</i></font>
							<table border="1" cellpadding="0" cellspacing="0" width="100%">
								<tr>
									<td width="70%" valign="top" align="center">
										<font class="titulopeque">CONCEPTO</font>
									</td>
									<td width="10%" valign="top" align="center">
										<font class="titulopeque">TIPO (%)</font>
									</td>
									<td width="20%" valign="top" align="center">
										<font class="titulopeque">IMPORTE</font>
									</td>
								</tr>
								<tr>
									<td width="70%" valign="top">
										<table border="0" cellpadding="0" cellspacing="0" width="100%">
											<xsl:for-each select="Charges/Charge">
												<tr>
													<td width="100%">
														<xsl:apply-templates select="ChargeReason"/>
													</td>
												</tr>
											</xsl:for-each>
										</table>
									</td>
									<td width="10%" valign="top">
										<table border="0" cellpadding="0" cellspacing="0" width="100%">
											<xsl:for-each select="Charges/Charge">
												<tr>
													<td width="100%" align="center">
														<xsl:choose>
															<xsl:when test='ChargeRate!=""' >
																<xsl:value-of select="ChargeRate"/>
															</xsl:when>
															<xsl:otherwise>
																-
															</xsl:otherwise>
														</xsl:choose>
													</td>
												</tr>
											</xsl:for-each>
										</table>
									</td>
									<td width="20%" valign="top">
										<table border="0" cellpadding="0" cellspacing="0" width="100%">
											<xsl:for-each select="Charges/Charge">
												<tr>
													<td align="right">
														<xsl:value-of select="ChargeAmount"/>
													</td>
												</tr>
											</xsl:for-each>
										</table>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td>&#160;</td>
					</tr>
					</xsl:if>
					<tr>
						<td width="100%">
							<table border="0" cellpadding="0" cellspacing="0" width="100%">
								<tr>
									<td width="80%" align="right">
										<font class="titulopeque">IMPORTE BRUTO&#160;&#160;&#160;&#160;&#160;</font>
									</td>
									<td width="20%" align="center">
										<table border="1" cellpadding="0" cellspacing="0" width="100%">
											<tr>
												<td align="right">
													<font class="titulopeque">
														<xsl:value-of select="GrossAmount"/>
													</font>
												</td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td>&#160;</td>
					</tr>
					<xsl:if test='TaxesOutputs!=""' >
					<tr>
						<td>
							<font class="titulopeque"><i>IMPUESTOS REPERCUTIDOS</i></font>
							<xsl:choose>
								<xsl:when test='//m:Facturae/FileHeader/Batch/InvoiceCurrencyCode="EUR"'>
									<table border="1" cellpadding="0" cellspacing="0" width="100%">
										<tr>
											<td width="35%" valign="top" align="center">
												<font class="titulopeque">CLASE DE IMPUESTO</font>
											</td>
											<td width="10%" valign="top" align="center">
												<font class="titulopeque">TIPO (%)</font>
											</td>
											<xsl:choose>
												<xsl:when test='TaxesOutputs/Tax/SpecialTaxableBase!=""' >
													<td width="15%" valign="top" align="center">
														<font class="titulopeque">BASE IMPONIBLE ESPECIAL</font>
													</td>
													<td width="15%" valign="top" align="center">
														<font class="titulopeque">CUOTA ESPECIAL</font>
													</td>
												</xsl:when>
												<xsl:otherwise>
													<td width="15%" valign="top" align="center">
														<font class="titulopeque">BASE IMPONIBLE</font>
													</td>
													<td width="15%" valign="top" align="center">
														<font class="titulopeque">CUOTA</font>
													</td>
												</xsl:otherwise>
											</xsl:choose>
											<td width="10%" valign="top" align="center">
												<font class="titulopeque">RECARGO EQUIV. (%)</font>
											</td>
											<td width="15%" valign="top" align="center">
												<font class="titulopeque">CUOTA RECARGO EQUIV.</font>
											</td>
										</tr>
										<tr>
											<td width="35%" valign="top">
												<table border="0" cellpadding="0" cellspacing="0" width="100%">
													<xsl:for-each select="TaxesOutputs/Tax">
														<tr>
															<td width="100%">
																<script>
																	document.write(descTipoImpuesto('<xsl:value-of select="TaxTypeCode"/>'));
																</script>
															</td>
														</tr>
													</xsl:for-each>
												</table>
											</td>
											<td width="10%" valign="top">
												<table border="0" cellpadding="0" cellspacing="0" width="100%">
													<xsl:for-each select="TaxesOutputs/Tax">
														<tr>
															<td width="100%" align="center">
																<xsl:choose>
																	<xsl:when test='TaxRate!=""' >
																		<xsl:value-of select="TaxRate"/>
																	</xsl:when>
																	<xsl:otherwise>
																		-
																	</xsl:otherwise>
																</xsl:choose>
															</td>
														</tr>
													</xsl:for-each>
												</table>
											</td>
											<td width="15%" valign="top">
												<table border="0" cellpadding="0" cellspacing="0" width="100%">
													<xsl:for-each select="TaxesOutputs/Tax">
														<tr>
															<td width="100%" align="right">
																<xsl:choose>
																	<xsl:when test='SpecialTaxableBase!=""' >
																		<xsl:value-of select="SpecialTaxableBase/TotalAmount"/>
																	</xsl:when>
																	<xsl:otherwise>
																		<xsl:value-of select="TaxableBase/TotalAmount"/>
																	</xsl:otherwise>
																</xsl:choose>
															</td>
														</tr>
													</xsl:for-each>
												</table>
											</td>
											<td width="15%" valign="top">
												<table border="0" cellpadding="0" cellspacing="0" width="100%">
													<xsl:for-each select="TaxesOutputs/Tax">
														<tr>
															<td align="right">
																<xsl:choose>
																	<xsl:when test='SpecialTaxAmount!=""' >
																		<xsl:value-of select="SpecialTaxAmount/TotalAmount"/>
																	</xsl:when>
																	<xsl:when test='TaxAmount!=""' >
																		<xsl:value-of select="TaxAmount/TotalAmount"/>
																	</xsl:when>
																	<xsl:otherwise>
																		-
																	</xsl:otherwise>
																</xsl:choose>
															</td>
														</tr>
													</xsl:for-each>
												</table>
											</td>
											<td width="10%" valign="top">
												<table border="0" cellpadding="0" cellspacing="0" width="100%">
													<xsl:for-each select="TaxesOutputs/Tax">
														<tr>
															<td width="100%" align="center">
																<xsl:choose>
																	<xsl:when test='EquivalenceSurcharge!=""' >
																		<xsl:value-of select="EquivalenceSurcharge"/>
																	</xsl:when>
																	<xsl:otherwise>
																		-
																	</xsl:otherwise>
																</xsl:choose>
															</td>
														</tr>
													</xsl:for-each>
												</table>
											</td>
											<td width="15%" valign="top">
												<table border="0" cellpadding="0" cellspacing="0" width="100%">
													<xsl:for-each select="TaxesOutputs/Tax">
														<tr>
															<td align="right">
																<xsl:choose>
																	<xsl:when test='EquivalenceSurchargeAmount!=""' >
																		<xsl:value-of select="EquivalenceSurchargeAmount/TotalAmount"/>
																	</xsl:when>
																	<xsl:otherwise>
																		-
																	</xsl:otherwise>
																</xsl:choose>
															</td>
														</tr>
													</xsl:for-each>
												</table>
											</td>
										</tr>
									</table>
								</xsl:when>
								<xsl:otherwise>
									<table border="1" cellpadding="0" cellspacing="0" width="100%">
										<tr>
											<td width="20%" align="center" rowspan="2">
												<font class="titulopeque">CLASE DE IMPUESTO</font>
											</td>
											<td width="7%" align="center" rowspan="2">
												<font class="titulopeque">TIPO (%)</font>
											</td>
											<xsl:choose>
												<xsl:when test='TaxesOutputs/Tax/SpecialTaxableBase!=""' >
													<td width="22%" valign="top" align="center" colspan="2">
														<font class="titulopeque">BASE IMPONIBLE ESPECIAL</font>
													</td>
													<td width="22%" valign="top" align="center" colspan="2">
														<font class="titulopeque">CUOTA ESPECIAL</font>
													</td>
												</xsl:when>
												<xsl:otherwise>
													<td width="22%" valign="top" align="center" colspan="2">
														<font class="titulopeque">BASE IMPONIBLE</font>
													</td>
													<td width="22%" valign="top" align="center" colspan="2">
														<font class="titulopeque">CUOTA</font>
													</td>
												</xsl:otherwise>
											</xsl:choose>
											<td width="7%" valign="top" align="center" rowspan="2">
												<font class="titulopeque">RECARGO EQUIV. (%)</font>
											</td>
											<td width="22%" valign="top" align="center" colspan="2">
												<font class="titulopeque">CUOTA RECARGO EQUIV.</font>
											</td>
										</tr>
										<tr>
											<td valign="top" align="center">
												<font class="titulopeque">Importe</font>
											</td>
											<td valign="top" align="center">
												<font class="titulopeque">Contravalor</font>
											</td>
											<td valign="top" align="center">
												<font class="titulopeque">Importe</font>
											</td>
											<td valign="top" align="center">
												<font class="titulopeque">Contravalor</font>
											</td>
											<td valign="top" align="center">
												<font class="titulopeque">Importe</font>
											</td>
											<td valign="top" align="center">
												<font class="titulopeque">Contravalor</font>
											</td>
										</tr>
										<tr>
											<td width="20%" valign="top">
												<table border="0" cellpadding="0" cellspacing="0" width="100%">
													<xsl:for-each select="TaxesOutputs/Tax">
														<tr>
															<td width="100%">
																<script>
																	document.write(descTipoImpuesto('<xsl:value-of select="TaxTypeCode"/>'));
																</script>
															</td>
														</tr>
													</xsl:for-each>
												</table>
											</td>
											<td width="7%" valign="top">
												<table border="0" cellpadding="0" cellspacing="0" width="100%">
													<xsl:for-each select="TaxesOutputs/Tax">
														<tr>
															<td width="100%" align="center">
																<xsl:choose>
																	<xsl:when test='TaxRate!=""' >
																		<xsl:value-of select="TaxRate"/>
																	</xsl:when>
																	<xsl:otherwise>
																		-
																	</xsl:otherwise>
																</xsl:choose>
															</td>
														</tr>
													</xsl:for-each>
												</table>
											</td>
											<td width="11%" valign="top">
												<table border="0" cellpadding="0" cellspacing="0" width="100%">
													<xsl:for-each select="TaxesOutputs/Tax">
														<tr>
															<td width="100%" align="right">
																<xsl:choose>
																	<xsl:when test='SpecialTaxableBase!=""' >
																		<xsl:value-of select="SpecialTaxableBase/TotalAmount"/>
																	</xsl:when>
																	<xsl:otherwise>
																		<xsl:value-of select="TaxableBase/TotalAmount"/>
																	</xsl:otherwise>
																</xsl:choose>
															</td>
														</tr>
													</xsl:for-each>
												</table>
											</td>
											<td width="11%" valign="top">
												<table border="0" cellpadding="0" cellspacing="0" width="100%">
													<xsl:for-each select="TaxesOutputs/Tax">
														<tr>
															<td width="100%" align="right">
																<xsl:choose>
																	<xsl:when test='SpecialTaxableBase!=""' >
																		<xsl:value-of select="SpecialTaxableBase/EquivalentInEuros"/>
																	</xsl:when>
																	<xsl:otherwise>
																		<xsl:value-of select="TaxableBase/EquivalentInEuros"/>
																	</xsl:otherwise>
																</xsl:choose>
															</td>
														</tr>
													</xsl:for-each>
												</table>
											</td>
											<td width="11%" valign="top">
												<table border="0" cellpadding="0" cellspacing="0" width="100%">
													<xsl:for-each select="TaxesOutputs/Tax">
														<tr>
															<td align="right">
																<xsl:choose>
																	<xsl:when test='SpecialTaxAmount!=""' >
																		<xsl:value-of select="SpecialTaxAmount/TotalAmount"/>
																	</xsl:when>
																	<xsl:when test='TaxAmount!=""' >
																		<xsl:value-of select="TaxAmount/TotalAmount"/>
																	</xsl:when>
																	<xsl:otherwise>
																		-
																	</xsl:otherwise>
																</xsl:choose>
															</td>
														</tr>
													</xsl:for-each>
												</table>
											</td>
											<td width="11%" valign="top">
												<table border="0" cellpadding="0" cellspacing="0" width="100%">
													<xsl:for-each select="TaxesOutputs/Tax">
														<tr>
															<td align="right">
																<xsl:choose>
																	<xsl:when test='SpecialTaxAmount!=""' >
																		<xsl:value-of select="SpecialTaxAmount/EquivalentInEuros"/>
																	</xsl:when>
																	<xsl:when test='TaxAmount!=""' >
																		<xsl:value-of select="TaxAmount/EquivalentInEuros"/>
																	</xsl:when>
																	<xsl:otherwise>
																		-
																	</xsl:otherwise>
																</xsl:choose>
															</td>
														</tr>
													</xsl:for-each>
												</table>
											</td>
											<td width="7%" valign="top">
												<table border="0" cellpadding="0" cellspacing="0" width="100%">
													<xsl:for-each select="TaxesOutputs/Tax">
														<tr>
															<td width="100%" align="center">
																<xsl:choose>
																	<xsl:when test='EquivalenceSurcharge!=""' >
																		<xsl:value-of select="EquivalenceSurcharge"/>
																	</xsl:when>
																	<xsl:otherwise>
																		-
																	</xsl:otherwise>
																</xsl:choose>
															</td>
														</tr>
													</xsl:for-each>
												</table>
											</td>
											<td width="11%" valign="top">
												<table border="0" cellpadding="0" cellspacing="0" width="100%">
													<xsl:for-each select="TaxesOutputs/Tax">
														<tr>
															<td align="right">
																<xsl:choose>
																	<xsl:when test='EquivalenceSurchargeAmount/TotalAmount!=""' >
																		<xsl:value-of select="EquivalenceSurchargeAmount/TotalAmount"/>
																	</xsl:when>
																	<xsl:otherwise>
																		-
																	</xsl:otherwise>
																</xsl:choose>
															</td>
														</tr>
													</xsl:for-each>
												</table>
											</td>
											<td width="11%" valign="top">
												<table border="0" cellpadding="0" cellspacing="0" width="100%">
													<xsl:for-each select="TaxesOutputs/Tax">
														<tr>
															<td align="right">
																<xsl:choose>
																	<xsl:when test='EquivalenceSurchargeAmount/EquivalentInEuros!=""' >
																		<xsl:value-of select="EquivalenceSurchargeAmount/EquivalentInEuros"/>
																	</xsl:when>
																	<xsl:otherwise>
																		-
																	</xsl:otherwise>
																</xsl:choose>
															</td>
														</tr>
													</xsl:for-each>
												</table>
											</td>
										</tr>
									</table>
								</xsl:otherwise>
							</xsl:choose>
						</td>
					</tr>
					<tr>
						<td>&#160;</td>
					</tr>
					</xsl:if>
					<xsl:if test='TaxesWithheld!=""' >
					<tr>
						<td>
							<font class="titulopeque"><i>IMPUESTOS RETENIDOS</i></font>
							<xsl:choose>
								<xsl:when test='//m:Facturae/FileHeader/Batch/InvoiceCurrencyCode="EUR"'>
									<table border="1" cellpadding="0" cellspacing="0" width="100%">
										<tr>
											<td width="50%" valign="top" align="center">
												<font class="titulopeque">CLASE DE IMPUESTO</font>
											</td>
											<td width="10%" valign="top" align="center">
												<font class="titulopeque">TIPO (%)</font>
											</td>
											<td width="20%" valign="top" align="center">
												<font class="titulopeque">BASE IMPONIBLE</font>
											</td>
											<td width="20%" valign="top" align="center">
												<font class="titulopeque">CUOTA</font>
											</td>
										</tr>
										<tr>
											<td width="50%" valign="top">
												<table border="0" cellpadding="0" cellspacing="0" width="100%">
													<xsl:for-each select="TaxesWithheld/Tax">
														<tr>
															<td width="100%">
																<script>
																	document.write(descTipoImpuesto('<xsl:value-of select="TaxTypeCode"/>'));
																</script>
															</td>
														</tr>
													</xsl:for-each>
												</table>
											</td>
											<td width="10%" valign="top">
												<table border="0" cellpadding="0" cellspacing="0" width="100%">
													<xsl:for-each select="TaxesWithheld/Tax">
														<tr>
															<td width="100%" align="center">
																<xsl:choose>
																	<xsl:when test='TaxRate!=""' >
																		<xsl:value-of  select="TaxRate"/>
																	</xsl:when>
																	<xsl:otherwise>
																		-
																	</xsl:otherwise>
																</xsl:choose>
															</td>
														</tr>
													</xsl:for-each>
												</table>
											</td>
											<td width="10%" valign="top">
												<table border="0" cellpadding="0" cellspacing="0" width="100%">
													<xsl:for-each select="TaxesWithheld/Tax">
														<tr>
															<td width="100%" align="right">
																<xsl:choose>
																	<xsl:when test='TaxableBase!=""' >
																		<xsl:value-of  select="TaxableBase/TotalAmount"/>
																	</xsl:when>
																	<xsl:otherwise>
																		-
																	</xsl:otherwise>
																</xsl:choose>
															</td>
														</tr>
													</xsl:for-each>
												</table>
											</td>
											<td width="20%" valign="top">
												<table border="0" cellpadding="0" cellspacing="0" width="100%">
													<xsl:for-each select="TaxesWithheld/Tax">
														<tr>
															<td align="right">
																<xsl:choose>
																	<xsl:when test='TaxAmount!=""' >
																		<xsl:value-of select="TaxAmount/TotalAmount"/>
																	</xsl:when>
																	<xsl:otherwise>
																		-
																	</xsl:otherwise>
																</xsl:choose>
															</td>
														</tr>
													</xsl:for-each>
												</table>
											</td>
										</tr>
									</table>
								</xsl:when>
								<xsl:otherwise>
									<table border="1" cellpadding="0" cellspacing="0" width="100%">
										<tr>
											<td width="30%" align="center" rowspan="2">
												<font class="titulopeque">CLASE DE IMPUESTO</font>
											</td>
											<td width="10%" align="center" rowspan="2">
												<font class="titulopeque">TIPO (%)</font>
											</td>
											<td width="30%" valign="top" align="center" colspan="2">
												<font class="titulopeque">BASE IMPONIBLE</font>
											</td>
											<td width="30%" valign="top" align="center" colspan="2">
												<font class="titulopeque">CUOTA</font>
											</td>
										</tr>
										<tr>
											<td valign="top" align="center">
												<font class="titulopeque">Importe</font>
											</td>
											<td valign="top" align="center">
												<font class="titulopeque">Contravalor</font>
											</td>
											<td valign="top" align="center">
												<font class="titulopeque">Importe</font>
											</td>
											<td valign="top" align="center">
												<font class="titulopeque">Contravalor</font>
											</td>
										</tr>
										<tr>
											<td width="30%" valign="top">
												<table border="0" cellpadding="0" cellspacing="0" width="100%">
													<xsl:for-each select="TaxesWithheld/Tax">
														<tr>
															<td width="100%">
																<script>
																	document.write(descTipoImpuesto('<xsl:value-of select="TaxTypeCode"/>'));
																</script>
															</td>
														</tr>
													</xsl:for-each>
												</table>
											</td>
											<td width="10%" valign="top">
												<table border="0" cellpadding="0" cellspacing="0" width="100%">
													<xsl:for-each select="TaxesWithheld/Tax">
														<tr>
															<td width="100%" align="center">
																<xsl:choose>
																	<xsl:when test='TaxRate!=""' >
																		<xsl:value-of select="TaxRate"/>
																	</xsl:when>
																	<xsl:otherwise>
																		-
																	</xsl:otherwise>
																</xsl:choose>
															</td>
														</tr>
													</xsl:for-each>
												</table>
											</td>
											<td width="15%" valign="top">
												<table border="0" cellpadding="0" cellspacing="0" width="100%">
													<xsl:for-each select="TaxesWithheld/Tax">
														<tr>
															<td width="100%" align="right">
																<xsl:choose>
																	<xsl:when test='TaxableBase/TotalAmount!=""' >
																		<xsl:value-of select="TaxableBase/TotalAmount"/>
																	</xsl:when>
																	<xsl:otherwise>
																		-
																	</xsl:otherwise>
																</xsl:choose>
															</td>
														</tr>
													</xsl:for-each>
												</table>
											</td>
											<td width="15%" valign="top">
												<table border="0" cellpadding="0" cellspacing="0" width="100%">
													<xsl:for-each select="TaxesWithheld/Tax">
														<tr>
															<td width="100%" align="right">
																<xsl:choose>
																	<xsl:when test='TaxableBase/EquivalentInEuros!=""' >
																		<xsl:value-of select="TaxableBase/EquivalentInEuros"/>
																	</xsl:when>
																	<xsl:otherwise>
																		-
																	</xsl:otherwise>
																</xsl:choose>
															</td>
														</tr>
													</xsl:for-each>
												</table>
											</td>
											<td width="15%" valign="top">
												<table border="0" cellpadding="0" cellspacing="0" width="100%">
													<xsl:for-each select="TaxesWithheld/Tax">
														<tr>
															<td align="right">
																<xsl:choose>
																	<xsl:when test='TaxAmount/TotalAmount!=""' >
																		<xsl:value-of select="TaxAmount/TotalAmount"/>
																	</xsl:when>
																	<xsl:otherwise>
																		-
																	</xsl:otherwise>
																</xsl:choose>
															</td>
														</tr>
													</xsl:for-each>
												</table>
											</td>
											<td width="15%" valign="top">
												<table border="0" cellpadding="0" cellspacing="0" width="100%">
													<xsl:for-each select="TaxesWithheld/Tax">
														<tr>
															<td align="right">
																<xsl:choose>
																	<xsl:when test='TaxAmount/EquivalentInEuros!=""' >
																		<xsl:value-of select="TaxAmount/EquivalentInEuros"/>
																	</xsl:when>
																	<xsl:otherwise>
																		-
																	</xsl:otherwise>
																</xsl:choose>
															</td>
														</tr>
													</xsl:for-each>
												</table>
											</td>
										</tr>
									</table>
								</xsl:otherwise>
							</xsl:choose>
						</td>
					</tr>
					<tr>
						<td>&#160;</td>
					</tr>
					</xsl:if>
					<xsl:if test='AdditionalLineItemInformation!=""' >
						<tr>
							<td>&#160;</td>
						</tr>
						<tr>
							<td>
								<hr/>
							</td>
						</tr>
						<tr>
							 <td width="100%">
								<table border="0" cellpadding="0" cellspacing="0" width="100%">
									<tr>
										<td>
											<font class="titulo2">
												OBSERVACIONES
											</font>
										</td>
									</tr>
									<tr>
										<td colspan="2">&#160;</td>
									</tr>
									<tr>
										<td width="100%">
											<xsl:apply-templates select="AdditionalLineItemInformation"/>
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</xsl:if>
				</table>
			</td>
		</tr>
		</table>
	</xsl:template>
	<xsl:template match="//m:Facturae/Invoices/Invoice/Items/InvoiceLine/DeliveryNotesReferences">
		<tr>
			<td>&#160;</td>
		</tr>
		<tr>
			<td>
				<hr/>
			</td>
		</tr>
		<tr>
			 <td width="100%">
				<table border="0" cellpadding="0" cellspacing="0" width="100%">
					<tr>
						<td>
							<font class="titulo2">
								ALBARANES
							</font>
						</td>
					</tr>
					<tr>
						<td colspan="2">&#160;</td>
					</tr>
					<tr>
						<td width="100%">
							<table border="1" cellpadding="0" cellspacing="0" width="70%">
								<tr>
									<td align="center" width="50%">
										<font class="titulopeque">Nº ALBARÁN</font>
									</td>
									<td align="center" width="50%">
										<font class="titulopeque">FECHA ALBARÁN</font>
									</td>
								</tr>
								<xsl:for-each select="DeliveryNote">
									<tr>
										<td align="center">
											<xsl:value-of select="DeliveryNoteNumber"/>
										</td>
										<td align="center">
											<xsl:value-of select="substring(DeliveryNoteDate,9,2)"/>-<xsl:value-of select="substring(DeliveryNoteDate,6,2)"/>-<xsl:value-of select="substring(DeliveryNoteDate,1,4)"/>
										</td>
									</tr>
								</xsl:for-each>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</xsl:template>
</xsl:stylesheet>
