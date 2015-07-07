using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;

namespace PostAround.Entities
{
    public static class Helpers
    {
        public static string Slugify(this string phrase)
        {
            string str = phrase.ToLower();
            str = Regex.Replace(str, @"[$&+,/:;=?@<>#%{}|\^~\[\]`]+", ""); // Remove all non valid chars         
            str = Regex.Replace(str, @"\s+", " ").Trim(); // convert multiple spaces into one space  
            str = Regex.Replace(str, @"\s", "-"); // Replace spaces by dashes
            return str;
        }

    }

}
