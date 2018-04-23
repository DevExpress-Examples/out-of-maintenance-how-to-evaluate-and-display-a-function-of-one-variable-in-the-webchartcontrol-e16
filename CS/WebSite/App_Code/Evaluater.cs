using System;
using System.Collections.Generic;
using System.Text;
using Microsoft.CSharp;
using System.CodeDom.Compiler;
using System.Reflection;
using System.Windows.Forms;

namespace ChartFunctionPlot {
    public class Evaluater {

        private static Type internalEvaluaterType = null;
        private static string code = "";

        public static string Code
        {
            get { return Evaluater.code; }
            set {
                if (Evaluater.code != value)
                {
                    Evaluater.code = value;
                    Evaluater.Compile();
                }
            }
        }

        private static void Compile()
        {
            CSharpCodeProvider c = new CSharpCodeProvider();
            CompilerParameters cp = new CompilerParameters();

            Assembly[] loadedAssemblies = AppDomain.CurrentDomain.GetAssemblies();

            foreach(Assembly asm in loadedAssemblies) {
                try {
                    cp.ReferencedAssemblies.Add(asm.Location);
                }
                catch { 
                }
            }

            cp.CompilerOptions = "/t:library";
            cp.GenerateInMemory = true;
            StringBuilder sb = new StringBuilder("");

            sb.Append("using System;\n");

            sb.Append("namespace ChartFunctionPlot { \n");
            sb.Append("public class EvaluaterClass { \n");
            sb.Append("public static object Evaluate(object param1, object param2) {");
            sb.Append("return (" + Evaluater.Code + ");");
            sb.Append("}\n");
            sb.Append("}\n");
            sb.Append("}\n");

            CompilerResults cr = c.CompileAssemblyFromSource(cp, sb.ToString());

            if(cr.Errors.Count > 0) {
                //MessageBox.Show("ERROR: " + cr.Errors[0].ErrorText, "Error evaluating cs code", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            internalEvaluaterType = cr.CompiledAssembly.GetType("ChartFunctionPlot.EvaluaterClass");
        }

        public static object Evaluate(object param1, object param2) {
            //MethodInfo mi = evaluater.GetMethod("Evaluate");
            //mi.Invoke(null, null);
            //.Replace("x", "param1").Replace("y", "param2") 

            if (Evaluater.internalEvaluaterType == null)
                Evaluater.Code = "null";

            return Evaluater.internalEvaluaterType.InvokeMember("Evaluate", BindingFlags.InvokeMethod | BindingFlags.Static | BindingFlags.Public, null, null, new object[] { param1, param2 }); 
        }
    }
}
