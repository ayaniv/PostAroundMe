using System.IO;
using System.Web.Caching;
using Portal.PCache.Parsers;

namespace Portal.PCache
{
    public static class FileCache
    {
        /// <summary>
        /// Gets the text file.
        /// </summary>
        /// <param name="path">The path.</param>
        /// <returns></returns>
        public static string GetTextFile(string path)
        {
            if (Exists(path))
            {
                return Get(path).ToString();
            }
            else
            {
                string data = ReadFile(path);
                Add(data, path);
                return data;
            }
        }
        /// <summary>
        /// Gets the text file using a file parser.
        /// </summary>
        /// <param name="path">The path.</param>
        /// <param name="parser">The parser.</param>
        /// <returns></returns>
        public static string GetTextFile(string path, IFileParser parser)
        {
            if (Exists(path))
            {
                return Get(path).ToString();
            }
            else
            {
                string data = parser.Parse(path);
                Add(data, path);
                return data;
            }
        }

        /// <summary>
        /// Reads the file form disk.
        /// </summary>
        /// <param name="path">The file path.</param>
        /// <returns></returns>
        private static string ReadFile(string path)
        {
            TextReader s = new StreamReader(path);
            string data = s.ReadToEnd();
            s.Close();
            s.Dispose();
            return data;
        }

        /// <summary>
        /// Adds the specified cache object.
        /// </summary>
        /// <param name="cacheObject">The cache object.</param>
        /// <param name="keyName">Name of the key.</param>
        private static void Add(object cacheObject, string keyName)
        {
            System.Web.HttpContext.Current.Cache.Insert(keyName, cacheObject, new CacheDependency(keyName));
        }

        /// <summary>
        /// Check if object exists in cache
        /// </summary>
        /// <param name="key"></param>
        /// <returns></returns>
        private static bool Exists(string key)
        {
            if (System.Web.HttpContext.Current.Cache[key] != null)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        /// <summary>
        /// remove object from cache
        /// </summary>
        /// <param name="key"></param>
        private static void Remove(string key)
        {
            System.Web.HttpContext.Current.Cache.Remove(key);
        }

        /// <summary>
        /// get object from cache
        /// </summary>
        /// <param name="key"></param>
        /// <returns></returns>
        public static object Get(string key)
        {
            return System.Web.HttpContext.Current.Cache[key];
        }
    }
}

