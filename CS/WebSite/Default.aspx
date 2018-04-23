<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<%@ Register Assembly="DevExpress.Web.v9.1, Version=9.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxRoundPanel" TagPrefix="dxrp" %>
<%@ Register Assembly="DevExpress.Web.ASPxEditors.v9.1, Version=9.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dxe" %>
<%@ Register Assembly="DevExpress.XtraCharts.v9.1.Web, Version=9.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.XtraCharts.Web" TagPrefix="dxchartsui" %>
<%@ Register Assembly="DevExpress.XtraCharts.v9.1, Version=9.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.XtraCharts" TagPrefix="cc1" %>
<%@ Register Assembly="DevExpress.Web.v9.1, Version=9.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dxp" %>
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
            <dxchartsui:WebChartControl ID="WebChartControl1" runat="server" DiagramTypeName="XYDiagram"
                Height="200px" Width="700px" ClientInstanceName="chart" OnCustomCallback="WebChartControl1_CustomCallback">
                <SeriesSerializable>
                    <cc1:Series ArgumentScaleType="Numerical" LabelTypeName="PointSeriesLabel" Name="Series 1"
                        PointOptionsTypeName="PointOptions" SeriesViewTypeName="LineSeriesView">
                        <View HiddenSerializableString="to be serialized">
                        </View>
                        <Label HiddenSerializableString="to be serialized" LineVisible="True" Visible="False">
                        </Label>
                        <PointOptions HiddenSerializableString="to be serialized">
                        </PointOptions>
                        <LegendPointOptions HiddenSerializableString="to be serialized">
                        </LegendPointOptions>
                    </cc1:Series>
                </SeriesSerializable>
                <SeriesTemplate LabelTypeName="SideBySideBarSeriesLabel" PointOptionsTypeName="PointOptions"
                    SeriesViewTypeName="SideBySideBarSeriesView">
                    <View HiddenSerializableString="to be serialized">
                    </View>
                    <Label HiddenSerializableString="to be serialized" LineVisible="True">
                    </Label>
                    <PointOptions HiddenSerializableString="to be serialized">
                    </PointOptions>
                    <LegendPointOptions HiddenSerializableString="to be serialized">
                    </LegendPointOptions>
                </SeriesTemplate>
                <Diagram>
                    <axisx visibleinpanesserializable="-1">
<range sidemarginsenabled="True"></range>
</axisx>
                    <axisy visibleinpanesserializable="-1">
<range sidemarginsenabled="True"></range>
</axisy>
                </Diagram>
                <FillStyle FillOptionsTypeName="SolidFillOptions">
                    <Options HiddenSerializableString="to be serialized"></Options>
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
            <BottomRightCorner Height="5px" Url="~/Images/ASPxRoundPanel/655510495/BottomRightCorner.png"
                Width="5px" />
            <NoHeaderTopRightCorner Height="5px" Url="~/Images/ASPxRoundPanel/655510495/NoHeaderTopRightCorner.png"
                Width="5px" />
            <HeaderRightEdge>
                <BackgroundImage HorizontalPosition="right" ImageUrl="~/Images/ASPxRoundPanel/655510495/HeaderRightEdge.png"
                    Repeat="NoRepeat" VerticalPosition="bottom" />
            </HeaderRightEdge>
            <Border BorderColor="#0000A0" BorderStyle="Solid" BorderWidth="1px" />
            <HeaderLeftEdge>
                <BackgroundImage HorizontalPosition="left" ImageUrl="~/Images/ASPxRoundPanel/655510495/HeaderLeftEdge.png"
                    Repeat="NoRepeat" VerticalPosition="bottom" />
            </HeaderLeftEdge>
            <HeaderStyle BackColor="#DEDEDE">
                <BorderLeft BorderStyle="None" />
                <BorderRight BorderStyle="None" />
                <BorderBottom BorderStyle="None" />
            </HeaderStyle>
            <TopRightCorner Height="5px" Url="~/Images/ASPxRoundPanel/655510495/TopRightCorner.png"
                Width="5px" />
            <HeaderContent>
                <BackgroundImage HorizontalPosition="left" ImageUrl="~/Images/ASPxRoundPanel/655510495/HeaderContent.png"
                    Repeat="RepeatX" VerticalPosition="bottom" />
            </HeaderContent>
            <NoHeaderTopLeftCorner Height="5px" Url="~/Images/ASPxRoundPanel/655510495/NoHeaderTopLeftCorner.png"
                Width="5px" />
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
            <TopLeftCorner Height="5px" Url="~/Images/ASPxRoundPanel/655510495/TopLeftCorner.png"
                Width="5px" />
            <BottomLeftCorner Height="5px" Url="~/Images/ASPxRoundPanel/655510495/BottomLeftCorner.png"
                Width="5px" />
        </dxrp:ASPxRoundPanel>
    </div>

    </form>
</body>
</html>
