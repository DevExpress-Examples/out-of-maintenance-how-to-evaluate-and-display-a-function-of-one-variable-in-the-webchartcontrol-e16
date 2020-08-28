<%@ Page Language="vb" AutoEventWireup="true" CodeFile="Default.aspx.vb" Inherits="_Default" %>

<%@ Register Assembly="DevExpress.Web.v16.1, Version=16.1.17.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web" TagPrefix="dxrp" %>
<%@ Register Assembly="DevExpress.Web.v16.1, Version=16.1.17.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web" TagPrefix="dxe" %>
<%@ Register Assembly="DevExpress.XtraCharts.v16.1.Web, Version=16.1.17.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.XtraCharts.Web" TagPrefix="dxchartsui" %>
<%@ Register Assembly="DevExpress.XtraCharts.v16.1, Version=16.1.17.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.XtraCharts" TagPrefix="cc1" %>
<%@ Register Assembly="DevExpress.Web.v16.1, Version=16.1.17.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web" TagPrefix="dxp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Untitled Page</title>

    <script language="javascript" type="text/javascript">

    function UpdateChartFunction(){
        if (txtStart.GetIsValid() && txtEnd.GetIsValid() && txtPoints.GetIsValid())
            chart.PerformCallback('EvaluateCommand_' + cbExpression.GetValue() + '|' + txtStart.GetText() + '|' + txtEnd.GetText() + '|' + txtPoints.GetText());
        else
            alert("Some values have invalid format. Please reenter them in the correct format and try again.");
    }

    </script>

</head>
<body>
    <form id="form1" runat="server">
    <div>
        <center>
            <dxchartsui:WebChartControl ID="WebChartControl1" runat="server" 
                Height="200px" Width="700px" ClientInstanceName="chart" 
                OnCustomCallback="WebChartControl1_CustomCallback" CrosshairEnabled="True">

<Legend Name="Default Legend"></Legend>
                <SeriesSerializable>
                    <cc1:Series ArgumentScaleType="Numerical"  Name="Series 1" LabelsVisibility="False"
                         >
                        <ViewSerializable>
<cc1:LineSeriesView>
                        </cc1:LineSeriesView>
</ViewSerializable>
                        <LabelSerializable>
<cc1:PointSeriesLabel>
                        </cc1:PointSeriesLabel>
</LabelSerializable>
                    </cc1:Series>
                </SeriesSerializable>
                <SeriesTemplate  
                    >
                    <ViewSerializable>
<cc1:SideBySideBarSeriesView>
                    </cc1:SideBySideBarSeriesView>
</ViewSerializable>
                    <LabelSerializable>
<cc1:SideBySideBarSeriesLabel>
                    </cc1:SideBySideBarSeriesLabel>
</LabelSerializable>
                </SeriesTemplate>
                <DiagramSerializable>
<cc1:XYDiagram>
                    <axisx visibleinpanesserializable="-1">
</axisx>
                    <axisy visibleinpanesserializable="-1">
</axisy>
                </cc1:XYDiagram>
</DiagramSerializable>
                <FillStyle >
                    <OptionsSerializable>
<cc1:SolidFillOptions></cc1:SolidFillOptions>
</OptionsSerializable>
                </FillStyle>
            </dxchartsui:WebChartControl>
        </center>
        <p>
            ViewType:
            <dxe:ASPxComboBox ID="cbViewType" runat="server" ValueType="System.String">
                <ClientSideEvents SelectedIndexChanged="function(s, e) {
    chart.PerformCallback('ChangeViewTypeCommand_' + cbViewType.GetValue());
}" />
            </dxe:ASPxComboBox>
        </p>
        <dxrp:ASPxRoundPanel ID="ASPxRoundPanel1" runat="server" Width="100%" BackColor="Cyan"
            HeaderText="Options">



            <Border BorderColor="#0000A0" BorderStyle="Solid" BorderWidth="1px" />

            <HeaderStyle BackColor="#DEDEDE">
                <BorderLeft BorderStyle="None" />
                <BorderRight BorderStyle="None" />
                <BorderBottom BorderStyle="None" />
            </HeaderStyle>

            <HeaderContent>
                <BackgroundImage HorizontalPosition="left" ImageUrl="~/Images/ASPxRoundPanel/655510495/HeaderContent.png"
                    Repeat="RepeatX" VerticalPosition="bottom" />
            </HeaderContent>

            <PanelCollection>
                <dxp:PanelContent runat="server">
                    <table width="100%">
                        <tr>
                            <td>
                                <dxe:ASPxLabel ID="ASPxLabel1" runat="server" Text="<div style='width:30px'>f(x)=</div>"
                                    EncodeHtml="false">
                                </dxe:ASPxLabel>
                            </td>
                            <td>
                                <dxe:ASPxComboBox ID="cbExpression" runat="server" 
                                    ClientInstanceName="cbExpression" DropDownStyle="DropDown">
                                </dxe:ASPxComboBox>
                            </td>
                            <td>
                                <dxe:ASPxLabel ID="ASPxLabel2" runat="server" Text="Start:">
                                </dxe:ASPxLabel>
                            </td>
                            <td>
                                <dxe:ASPxTextBox ID="txtStart" runat="server" Width="50px" Text="-2" ClientInstanceName="txtStart">
                                    <ValidationSettings Display="Dynamic">
                                        <RegularExpression ErrorText="Invalid value" 
                                            ValidationExpression="-?\d+\.?\d*" />
                                        <RequiredField IsRequired="True" />
                                    </ValidationSettings>
                                </dxe:ASPxTextBox>
                            </td>
                            <td>
                                <dxe:ASPxLabel ID="ASPxLabel3" runat="server" Text="End:">
                                </dxe:ASPxLabel>
                            </td>
                            <td>
                                <dxe:ASPxTextBox ID="txtEnd" runat="server" Width="50px" Text="2" ClientInstanceName="txtEnd">
                                    <ValidationSettings Display="Dynamic">
                                        <RegularExpression ErrorText="Invalid value" 
                                            ValidationExpression="-?\d+\.?\d*" />
                                        <RequiredField IsRequired="True" />
                                    </ValidationSettings>
                                </dxe:ASPxTextBox>
                            </td>
                            <td>
                                <dxe:ASPxLabel ID="ASPxLabel4" runat="server" Text="Points:">
                                </dxe:ASPxLabel>
                            </td>
                            <td>
                                <dxe:ASPxTextBox ID="txtPoints" runat="server" Width="50px" Text="10" ClientInstanceName="txtPoints">
                                    <ValidationSettings Display="Dynamic">
                                        <RegularExpression ErrorText="Invalid value" ValidationExpression="\d+" />
                                    </ValidationSettings>
                                </dxe:ASPxTextBox>
                            </td>
                            <td>
                                <dxe:ASPxButton ID="ASPxButton1" runat="server" Text="Evaluate" AutoPostBack="false">
                                    <ClientSideEvents Click="function(s, e) {
    UpdateChartFunction();
}" />
                                </dxe:ASPxButton>
                            </td>
                        </tr>
                    </table>
                </dxp:PanelContent>
            </PanelCollection>


        </dxrp:ASPxRoundPanel>
    </div>

    </form>
</body>
</html>