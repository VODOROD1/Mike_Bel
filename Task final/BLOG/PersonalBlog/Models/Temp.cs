﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PersonalBlog.Models
{
    public static class Temp
    {
        public static int selectedPostId = 0;
        public static IList<int> selectedPostsId = new List<int>();
        public static int selectedUserId = -1;
        public static int selectedTegId = 0;
        public static int selectedCategoryId = 0;
        public static String message1 = null;
        public static bool showMeta = false;
        public static bool showComments = false;
    }
}