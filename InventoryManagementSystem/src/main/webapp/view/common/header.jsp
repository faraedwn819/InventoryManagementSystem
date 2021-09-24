<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <a class="navbar-brand" href="dashboard">Inventory System</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNavDropdown">
      <ul class="navbar-nav">
        <li class="nav-item active">
          <a class="nav-link" href="dashboard">Home</a>
        </li>
        
        <%
        Object userName = session.getAttribute("userName");
        if(userName != null && userName.toString() != null && !userName.toString().equals("")){
        	%>
        	<li class="nav-item">
          <form action="logout" method="POST">
          <button type="submit" class="btn btn-info">logout</button>
          </form>
        </li>
        <%
        }
        %>
      </ul>
    </div>
  </nav>