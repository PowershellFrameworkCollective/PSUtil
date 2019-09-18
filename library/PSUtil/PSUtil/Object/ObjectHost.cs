using System;
using System.Collections.Concurrent;
using System.Management.Automation;

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
        public static ConcurrentDictionary<string, ScriptBlock> ExpandedTypes = new ConcurrentDictionary<string, ScriptBlock>(StringComparer.InvariantCultureIgnoreCase);

        /// <summary>
        /// List of registered conversions
        /// </summary>
        public static ConcurrentDictionary<string, ObjectConversionMapping> Conversions = new ConcurrentDictionary<string, ObjectConversionMapping>(StringComparer.InvariantCultureIgnoreCase);
    }
}
