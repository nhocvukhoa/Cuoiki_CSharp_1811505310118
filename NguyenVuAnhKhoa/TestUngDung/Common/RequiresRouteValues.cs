using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Diagnostics.CodeAnalysis;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.Mvc;

namespace TestUngDung.Common
{
    [SuppressMessage("Microsoft.Design", "CA1019:DefineAccessorsForAttributeArguments")]
    [AttributeUsage(AttributeTargets.Class | AttributeTargets.Method, AllowMultiple = true, Inherited = true)]
    public sealed class RequiresRouteValues : ActionMethodSelectorAttribute
    {
        #region Properties

        /// <summary>
        /// Gets required route value names.
        /// </summary>
        public ReadOnlyCollection<string> Names { get; private set; }

        /// <summary>
        /// Gets or sets a value indicating whether to include form fields in the check.
        /// </summary>
        /// <value><c>true</c> if form fields should be included; otherwise, <c>false</c>.</value>
        public bool IncludeFormFields { get; set; }

        /// <summary>
        /// Gets or sets a value indicating whether to include query variables in the check.
        /// </summary>
        /// <value>
        ///     <c>true</c> if query variables should be included; otherwise, <c>false</c>.
        /// </value>
        public bool IncludeQueryVariables { get; set; }

        #endregion

        #region Constructors


        private RequiresRouteValues()
        {
            this.IncludeFormFields = true;
            this.IncludeQueryVariables = true;
        }


        public RequiresRouteValues(string commaSeparatedNames)
            : this((commaSeparatedNames ?? string.Empty).Split(','))
        {
            // does nothing
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="RequiresRouteValuesAttribute"/> class.
        /// </summary>
        /// <param name="names">Required route value names.</param>
        public RequiresRouteValues(IEnumerable<string> names)
            : this()
        {
            if (names == null || names.Count().Equals(0))
            {
                throw new ArgumentNullException("names");
            }

            // store names
            this.Names = new ReadOnlyCollection<string>(names.Select(val => val.Trim()).ToList());
        }

        #endregion

        #region ActionMethodSelectorAttribute implementation

        /// <summary>
        /// Determines whether the action method selection is valid for the specified controller context.
        /// </summary>
        /// <param name="controllerContext">The controller context.</param>
        /// <param name="methodInfo">Information about the action method.</param>
        /// <returns>
        /// true if the action method selection is valid for the specified controller context; otherwise, false.
        /// </returns>
        public override bool IsValidForRequest(ControllerContext controllerContext, MethodInfo methodInfo)
        {
            if (controllerContext == null)
            {
                throw new ArgumentNullException("controllerContext");
            }

            // always include route values
            HashSet<string> uniques = new HashSet<string>(controllerContext.RouteData.Values.Keys);

            // include form fields if required
            if (this.IncludeFormFields)
            {
                uniques.UnionWith(controllerContext.HttpContext.Request.Form.AllKeys);
            }

            // include query string variables if required
            if (this.IncludeQueryVariables)
            {
                uniques.UnionWith(controllerContext.HttpContext.Request.QueryString.AllKeys);
            }

            // determine whether all route values are present
            return this.Names.All(val => uniques.Contains(val));
        }

       

        #endregion
    }
}