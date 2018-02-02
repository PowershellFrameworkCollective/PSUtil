using System;
using System.Collections.Generic;
using System.Linq;
using System.Management.Automation;
using System.Text;
using System.Threading.Tasks;

namespace PSUtil.Object
{
    /// <summary>
    /// Contains all the information needed to convert one object type to another
    /// </summary>
    public class ObjectConversionMapping
    {
        /// <summary>
        /// From what to convert
        /// </summary>
        public string From;

        /// <summary>
        /// To what to convert
        /// </summary>
        public string To;

        /// <summary>
        /// The logic that does the converting
        /// </summary>
        public ScriptBlock Script;
    }
}
