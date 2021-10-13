namespace PSUtil.Utility
{
    /// <summary>
    /// Static tools of convenience
    /// </summary>
    public static class UtilityHost
    {
        /// <summary>
        /// Tell the system, that something really, really important is happening here and screensaver would ruin the day
        /// </summary>
        public static void DisableScreensaver()
        {
            NativeMethods.SetThreadExecutionState(ExecutionState.DisplayRequired);
            NativeMethods.SetThreadExecutionState(ExecutionState.SystemRequired | ExecutionState.AwayModeRequired | ExecutionState.Continuous);
        }
        /// <summary>
        /// Tell the system, that the screensaver may now be safely deployed again.
        /// </summary>
        public static void EnableScreensaver()
        {
            NativeMethods.SetThreadExecutionState(ExecutionState.Continuous);
        }
    }
}
