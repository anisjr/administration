<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="com.google.appengine.api.blobstore.*"%>
<%@ page import="cloudupload.Upload"%>

<%
    BlobstoreService blobstoreService = BlobstoreServiceFactory
            .getBlobstoreService();
%>

<!DOCTYPE html>
<html>
<head>
<title>Beity Administration</title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
<link href="css/style.css" rel="stylesheet" media="screen">
</head>
<body>

	<div class="container-narrow">

		<div class="masthead">
			<ul class="nav nav-pills pull-right">
				<li class="active"><a href="/">Accueil</a></li>
				<li><a href="#list">Liste des maisons</a></li>
				<li><a href="#upload">Ajouter</a></li>
			</ul>
			<h3 class="muted">Beity Administration</h3>
		</div>

		<hr />

		<div class="jumbotron">
			<h1>
				Administration des maisons<br />
			</h1>
			
			<a class="btn btn-large btn-success" href="#upload">Ajouter une
				maison</a>
		</div>

		<hr />

		<div class="row-fluid iconlist" id="list">

			<h2>Liste des maisons</h2>

			<p>
				
			</p>

			<%
			    List<Upload> uploads = (List<Upload>) request.getAttribute("uploads");
				if (uploads.size() == 0) {
				    %>

			<p>
				<em>Aucune maison ajoutée</em>
			</p>

			<%
				}
				else {
				int i = 0;
			    for (Upload upload : uploads) {
			        if ((i % 3) == 0) {
			%>
			<div class="row">
				<% } %>

				<div class="span4">
					<figure>
						<img src="<%=upload.getUrl()%>" alt="Image utilisateur"
							class="img-polaroid" style="max-width: 100px;" />
						<figcaption><a class="close" href="/?delete=<%=upload.getKeyString() %>">&times;</a> <%=upload.getDescription()%> <%=upload.getLogin()%> <%=upload.getWebservice()%></figcaption>
					</figure>
				</div>

				<%
			if ((i % 3) == 2 || i == uploads.size() - 1) {
				%>
			</div>
			<%			}
						i++;
					}
			    }%>

		</div>

		<hr />

		<div class="row-fluid iconlist" id="upload">

			<h2>Ajouter une maison</h2>

			<form
				action="<%= blobstoreService.createUploadUrl("/") %>"
				method="post" enctype="multipart/form-data">
				<p>
					<label>Image : <input type="file"
						name="uploadedFile" /></label>
				</p>
				<p>
					<label>Description : <input type="text"
						name="description" /></label>
				</p>
				<p>
					<label>Login : <input type="text"
						name="login" /></label>
				</p>
				<p>
					<label>Webservice : <input type="text"
						name="webservice" /></label>
				</p>
				<div class="form-actions">
					<input type="submit" class="btn" />
				</div>
			</form>
		</div>

	</div>
	<script src="http://code.jquery.com/jquery.js"></script>
	<script src="js/bootstrap.min.js"></script>
</body>
</html>
