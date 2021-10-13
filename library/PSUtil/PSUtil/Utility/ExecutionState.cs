using System;

namespace PSUtil.Utility
{
    /// <summary>
    /// The state of the current console
    /// </summary>
    [Flags]
    public enum ExecutionState : uint
    {
        /// <summary>
        /// Critical system resources are in use. Used for backups
        /// </summary>
        SystemRequired = 1,

        /// <summary>
        /// Display must not be turned off. Used when running video software
        /// </summary>
        DisplayRequired = 2,

        /// <summary>
        /// There's an actual user around
        /// </summary>
        UserPresent = 4,

        /// <summary>
        /// User must be away
        /// </summary>
        AwayModeRequired = 0x40,

        /// <summary>
        /// Something is happening for some time still
        /// </summary>
        Continuous = 0x80000000
    }
}
