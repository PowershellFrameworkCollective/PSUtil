using System;
using System.Collections.Generic;
using System.Linq;
using System.Management.Automation;
using System.Text;
using System.Threading.Tasks;

namespace PSUtil.Object
{
    /// <summary>
    /// Class that hosts static information and helpers for the object type functions
    /// </summary>
    public static class ObjectHost
    {
        /// <summary>
        /// Dictionary of types for which special expansion has been prepared.
        /// </summary>
        public static Dictionary<string, ScriptBlock> ExpandedTypes = new Dictionary<string, ScriptBlock>();
    }
}
