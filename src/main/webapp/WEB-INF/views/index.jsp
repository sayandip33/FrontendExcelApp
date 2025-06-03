<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html>
<head>
<title>Account Manager</title>
<link rel="stylesheet" href="/css/style.css" />
<script src="/js/upload-handler.js" defer></script>
</head>
<body>
	<nav class="navbar">
		<div class="nav-container">
			<div class="nav-logo">AccountManager</div>
			<ul class="nav-menu">
				<li class="nav-item"><a href="#" class="nav-link active">Home</a></li>
				<li class="nav-item"><a href="#" class="nav-link">Upload</a></li>
				<li class="nav-item"><a href="#" class="nav-link">Search</a></li>
				<li class="nav-item"><a href="#" class="nav-link">About</a></li>
			</ul>
		</div>
	</nav>

	<div class="tab-container">
		<h2>Upload Excel File (.xlsx)</h2>
		<input type="file" id="excelFile" accept=".xlsx" />
		<button onclick="validateAndUpload()">Upload</button>
		<button onclick="clearUpload()">Clear</button>
		<p id="response"></p>

		<hr>

		<h2>Search Account</h2>
		<input type="text" id="searchAccount"
			placeholder="Enter 14-digit Account Number" maxlength="14" />
		<button onclick="searchAccount()">Search</button>

		<table id="resultTable" class="result-table">
			<thead>
				<tr>
					<th>Account Number</th>
					<th>Created/Updated/Active</th>
					<th>Transfer Number</th>
					<th>Action</th>
				</tr>
			</thead>
			<tbody id="resultBody"></tbody>
		</table>
	</div>
</body>
</html>
