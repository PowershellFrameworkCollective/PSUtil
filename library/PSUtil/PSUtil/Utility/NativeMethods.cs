using System.Runtime.InteropServices;

namespace PSUtil.Utility
{
    /// <summary>
    /// Internal helper tool for direct access to windows APIs
    /// </summary>
    internal static class NativeMethods
    {
        [DllImport("kernel32.dll", CharSet = CharSet.Auto, SetLastError = true)]
        internal static extern ExecutionState SetThreadExecutionState(ExecutionState asFlags);
    }
}
