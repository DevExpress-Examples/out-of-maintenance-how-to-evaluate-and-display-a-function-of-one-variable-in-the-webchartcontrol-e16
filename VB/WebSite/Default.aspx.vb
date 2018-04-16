Imports System
Imports System.Configuration
Imports System.Data
Imports System.Web
Imports System.Web.Security
Imports System.Web.UI
Imports System.Web.UI.HtmlControls
Imports System.Web.UI.WebControls
Imports System.Web.UI.WebControls.WebParts
Imports DevExpress.XtraCharts
Imports ChartFunctionPlot

Partial Public Class _Default
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not IsPostBack Then
            ClientScript.RegisterStartupScript(Me.GetType(), "InitalChartUpdate", "<script language='javascript' type='text/javascript'>UpdateChartFunction();</script>")

            FillViewTypesComboBox()
            FillFunctionsComboBox()
        End If
    End Sub

    Protected Sub WebChartControl1_CustomCallback(ByVal sender As Object, ByVal e As DevExpress.XtraCharts.Web.CustomCallbackEventArgs)
        Dim cmdAndParams() As String = e.Parameter.Split(New String() {"_"}, StringSplitOptions.RemoveEmptyEntries)
        Dim command As String = cmdAndParams(0)
        Dim parameters() As String = cmdAndParams(1).Split(New String() { "|" }, StringSplitOptions.RemoveEmptyEntries)

        If command = "ChangeViewTypeCommand" Then
            WebChartControl1.Series(0).ChangeView(DirectCast(System.Enum.Parse(GetType(ViewType), parameters(0)), ViewType))
        ElseIf command = "EvaluateCommand" Then
            Dim expr As String = parameters(0).Replace("x", "Convert.ToDouble(param1)").Replace("y", "Convert.ToDouble(param2)")
            Dim start As Double = Double.Parse(parameters(1), System.Globalization.CultureInfo.InvariantCulture.NumberFormat)
            Dim [end] As Double = Double.Parse(parameters(2), System.Globalization.CultureInfo.InvariantCulture.NumberFormat)
            Dim points As Integer = Integer.Parse(parameters(3), System.Globalization.CultureInfo.InvariantCulture.NumberFormat)

            Evaluater.Code = expr

            WebChartControl1.Series(0).Points.Clear()
            For x As Double = start To [end] Step ([end] - start) / (points - 1)
                WebChartControl1.Series(0).Points.Add(New SeriesPoint(x, Convert.ToDouble(Evaluater.Evaluate(x, 0))))
            Next x
        End If
    End Sub

    Private Sub FillViewTypesComboBox()
        cbViewType.Items.Add("Line")
        cbViewType.Items.Add("Point")
        cbViewType.Items.Add("Bar")
        cbViewType.Items.Add("Area")
        cbViewType.Items.Add("Spline")
        cbViewType.SelectedIndex = 0
    End Sub

    Private Sub FillFunctionsComboBox()
        cbExpression.Items.Add("x")
        cbExpression.Items.Add("x*x - 10*x + 2")
        cbExpression.Items.Add("Math.Sin(x)")
        cbExpression.Items.Add("Math.Cos(x)")
        cbExpression.Items.Add("Math.Pow(2, x)")
        cbExpression.Items.Add("(x<=0?Math.Sin(x):x)")
        cbExpression.SelectedIndex = 0
        cbExpression.DataBind()
    End Sub
End Class
