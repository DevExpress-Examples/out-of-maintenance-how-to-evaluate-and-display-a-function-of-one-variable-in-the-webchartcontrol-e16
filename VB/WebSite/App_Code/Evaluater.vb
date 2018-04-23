Imports Microsoft.VisualBasic
Imports System
Imports System.Collections.Generic
Imports System.Text
Imports Microsoft.CSharp
Imports System.CodeDom.Compiler
Imports System.Reflection
Imports System.Windows.Forms

Namespace ChartFunctionPlot
	Public Class Evaluater

		Private Shared internalEvaluaterType As Type = Nothing
		Private Shared code_Renamed As String = ""

		Public Shared Property Code() As String
			Get
				Return Evaluater.code
			End Get
			Set(ByVal value As String)
				If Evaluater.code <> value Then
					Evaluater.code = value
					Evaluater.Compile()
				End If
			End Set
		End Property

		Private Shared Sub Compile()
			Dim c As New CSharpCodeProvider()
			Dim cp As New CompilerParameters()

			Dim loadedAssemblies() As System.Reflection.Assembly = AppDomain.CurrentDomain.GetAssemblies()

			For Each asm As System.Reflection.Assembly In loadedAssemblies
				Try
					cp.ReferencedAssemblies.Add(asm.Location)
				Catch
				End Try
			Next asm

			cp.CompilerOptions = "/t:library"
			cp.GenerateInMemory = True
			Dim sb As New StringBuilder("")

			sb.Append("using System;" & Constants.vbLf)

			sb.Append("namespace ChartFunctionPlot { " & Constants.vbLf)
			sb.Append("public class EvaluaterClass { " & Constants.vbLf)
			sb.Append("public static object Evaluate(object param1, object param2) {")
			sb.Append("return (" & Evaluater.Code & ");")
			sb.Append("}" & Constants.vbLf)
			sb.Append("}" & Constants.vbLf)
			sb.Append("}" & Constants.vbLf)

			Dim cr As CompilerResults = c.CompileAssemblyFromSource(cp, sb.ToString())

			If cr.Errors.Count > 0 Then
				'MessageBox.Show("ERROR: " + cr.Errors[0].ErrorText, "Error evaluating cs code", MessageBoxButtons.OK, MessageBoxIcon.Error);
				Return
			End If

			internalEvaluaterType = cr.CompiledAssembly.GetType("ChartFunctionPlot.EvaluaterClass")
		End Sub

		Public Shared Function Evaluate(ByVal param1 As Object, ByVal param2 As Object) As Object
			'MethodInfo mi = evaluater.GetMethod("Evaluate");
			'mi.Invoke(null, null);
			'.Replace("x", "param1").Replace("y", "param2") 

			If Evaluater.internalEvaluaterType Is Nothing Then
				Evaluater.Code = "null"
			End If

			Return Evaluater.internalEvaluaterType.InvokeMember("Evaluate", BindingFlags.InvokeMethod Or BindingFlags.Static Or BindingFlags.Public, Nothing, Nothing, New Object() { param1, param2 })
		End Function
	End Class
End Namespace
