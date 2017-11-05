using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PSUtil.Configuration
{
    /// <summary>
    /// The ways in which help can be displayed
    /// </summary>
    public enum HelpOption
    {
        /// <summary>
        /// Only show basic help
        /// </summary>
        Short,

        /// <summary>
        /// Show detailed help
        /// </summary>
        Detailed,

        /// <summary>
        /// Only show the examples section
        /// </summary>
        Examples,

        /// <summary>
        /// Show everything
        /// </summary>
        Full,

        /// <summary>
        /// Show help in a popup window
        /// </summary>
        Window,

        /// <summary>
        /// Show the help website
        /// </summary>
        Online
    }
}
