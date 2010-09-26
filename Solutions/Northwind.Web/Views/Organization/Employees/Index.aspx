<%@ Page Title="Employees" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" AutoEventWireup="true" 
	Inherits="System.Web.Mvc.ViewPage<IEnumerable<Northwind.Core.Organization.Employee>>" %>
<%@ Import Namespace="Northwind.Web.Controllers" %>
<%@ Import Namespace="Northwind.Web.Controllers.Organization" %>

<asp:Content ContentPlaceHolderID="MainContentPlaceHolder" runat="server">
    <h1>Employees</h1>

    <%
        if (this.ViewContext.TempData[ControllerEnums.GlobalViewDataProperty.PageMessage.ToString()] != null)
        {%>
        <p id="pageMessage"><%=this.ViewContext.TempData[ControllerEnums.GlobalViewDataProperty.PageMessage.ToString()]%></p>
    <%
        }%>

    <table>
        <thead>
            <tr>
			    <th>FirstName</th>
			    <th>LastName</th>
			    <th>PhoneExtension</th>
			    <th colspan="3">Action</th>
            </tr>
        </thead>

		<%
        foreach (var employee in this.ViewData.Model)
        {%>
			<tr>
				<td><%=employee.FirstName%></td>
				<td><%=employee.LastName%></td>
				<td><%=employee.PhoneExtension%></td>
				<td><%=this.Html.ActionLink<EmployeesController>(c => c.Show(employee.Id), "Details ")%></td>
				<td><%=this.Html.ActionLink<EmployeesController>(c => c.Edit(employee.Id), "Edit")%></td>
				<td>
    				<%
            using (this.Html.BeginForm<EmployeesController>(c => c.Delete(employee.Id)))
            {%>
                        <%=this.Html.AntiForgeryToken()%>
    				    <input type="submit" value="Delete" onclick="return confirm('Are you sure?');" />
                    <%
            }%>
				</td>
			</tr>
		<%
        }%>
    </table>

    <p><%=this.Html.ActionLink<EmployeesController>(c => c.Create(), "Create New Employee")%></p>
</asp:Content>