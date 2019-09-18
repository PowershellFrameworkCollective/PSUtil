using System;

namespace PSUtil.Utility
{
    /// <summary>
    /// HUmanly friendly representation of a timespan
    /// </summary>
    public class PsuTimeSpanPretty : PsuTimeSpan
    {
        #region Methods
        /// <summary>
        /// Creates a new, pretty timespan object from milliseconds
        /// </summary>
        /// <param name="Milliseconds">The milliseconds to convert from.</param>
        /// <returns>A pretty timespan object</returns>
        public static PsuTimeSpanPretty FromMilliseconds(double Milliseconds)
        {
            return new PsuTimeSpanPretty((long)(Milliseconds * 10000));
        }
        #endregion Methods

        #region Fields
        /// <summary>
        /// The number of digits a pretty timespan should round to.
        /// </summary>
        public int Digits = 2;
        #endregion Fields

        #region Constructors
        /// <summary>
        /// 
        /// </summary>
        /// <param name="Timespan"></param>
        public PsuTimeSpanPretty(TimeSpan Timespan)
            : base(Timespan)
        {

        }

        /// <summary>
        /// Converts a string into a timespan
        /// </summary>
        /// <param name="Timespan">The string to convert</param>
        public PsuTimeSpanPretty(string Timespan)
            : base(Timespan)
        {

        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="ticks"></param>
        public PsuTimeSpanPretty(long ticks)
            : base(ticks)
        {

        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="hours"></param>
        /// <param name="minutes"></param>
        /// <param name="seconds"></param>
        public PsuTimeSpanPretty(int hours, int minutes, int seconds)
            : base(hours, minutes, seconds)
        {

        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="days"></param>
        /// <param name="hours"></param>
        /// <param name="minutes"></param>
        /// <param name="seconds"></param>
        public PsuTimeSpanPretty(int days, int hours, int minutes, int seconds)
            : base(days, hours, minutes, seconds)
        {

        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="days"></param>
        /// <param name="hours"></param>
        /// <param name="minutes"></param>
        /// <param name="seconds"></param>
        /// <param name="milliseconds"></param>
        public PsuTimeSpanPretty(int days, int hours, int minutes, int seconds, int milliseconds)
            : base(days, hours, minutes, seconds, milliseconds)
        {

        }
        #endregion Constructors

        /// <summary>
        /// Creates extra-nice timespan formats
        /// </summary>
        /// <returns>Humanly readable timespans</returns>
        public override string ToString()
        {
            string temp = "";

            if (_timespan.TotalSeconds < 1)
            {
                temp = Math.Round(_timespan.TotalMilliseconds, Digits).ToString() + " ms";
            }
            else if (_timespan.TotalSeconds <= 60)
            {
                temp = Math.Round(_timespan.TotalSeconds, Digits).ToString() + " s";
            }
            else
            {
                if (_timespan.Ticks % 10000000 == 0) { return _timespan.ToString(); }
                else
                {
                    temp = _timespan.ToString();

                    temp = temp.Substring(0, temp.LastIndexOf("."));

                    return temp;
                }
            }

            return temp;
        }
    }
}
