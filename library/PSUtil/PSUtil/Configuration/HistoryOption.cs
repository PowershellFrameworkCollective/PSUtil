using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PSUtil.Configuration
{
    /// <summary>
    /// The options on where you search for your history
    /// </summary>
    public enum HistoryOption
    {
        /// <summary>
        /// Only the history from the current session is shown
        /// </summary>
        Session,

        /// <summary>
        /// Uses the PSReadline command history to show all commands ever sent
        /// </summary>
        Global
    }
}
