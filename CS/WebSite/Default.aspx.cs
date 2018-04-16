using System;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using DevExpress.XtraCharts;
using ChartFunctionPlot;

public partial class _Default : System.Web.UI.Page 
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "InitalChartUpdate",
                "<script language='javascript' type='text/javascript'>UpdateChartFunction();</script>");

            FillViewTypesComboBox();
            FillFunctionsComboBox();
        }
    }

    protected void WebChartControl1_CustomCallback(object sender, DevExpress.XtraCharts.Web.CustomCallbackEventArgs e)
    {
        string[] cmdAndParams = e.Parameter.Split(new string[] {"_"}, StringSplitOptions.RemoveEmptyEntries);
        string command = cmdAndParams[0];
        string[] parameters = cmdAndParams[1].Split(new string[] { "|" }, StringSplitOptions.RemoveEmptyEntries);

        if (command == "ChangeViewTypeCommand")
        {
            WebChartControl1.Series[0].ChangeView((ViewType)Enum.Parse(typeof(ViewType), parameters[0]));
        }
        else if (command == "EvaluateCommand")
        {
            string expr = parameters[0].Replace("x", "Convert.ToDouble(param1)").Replace("y", "Convert.ToDouble(param2)");
            double start = double.Parse(parameters[1], System.Globalization.CultureInfo.InvariantCulture.NumberFormat);
            double end = double.Parse(parameters[2], System.Globalization.CultureInfo.InvariantCulture.NumberFormat);
            int points = int.Parse(parameters[3], System.Globalization.CultureInfo.InvariantCulture.NumberFormat);

            Evaluater.Code = expr;

            WebChartControl1.Series[0].Points.Clear();
            for (double x = start; x <= end; x += (end - start) / (points - 1))
                WebChartControl1.Series[0].Points.Add(new SeriesPoint(x, Convert.ToDouble(Evaluater.Evaluate(x, 0))));
        }
    }

    private void FillViewTypesComboBox()
    {
        cbViewType.Items.Add("Line");
        cbViewType.Items.Add("Point");
        cbViewType.Items.Add("Bar");
        cbViewType.Items.Add("Area");
        cbViewType.Items.Add("Spline");
        cbViewType.SelectedIndex = 0;
    }

    private void FillFunctionsComboBox()
    {
        cbExpression.Items.Add("x");
        cbExpression.Items.Add("x*x - 10*x + 2");
        cbExpression.Items.Add("Math.Sin(x)");
        cbExpression.Items.Add("Math.Cos(x)");
        cbExpression.Items.Add("Math.Pow(2, x)");
        cbExpression.Items.Add("(x<=0?Math.Sin(x):x)");
        cbExpression.SelectedIndex = 0;
        cbExpression.DataBind();
    }
}
