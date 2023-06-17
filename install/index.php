<!doctype html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	<script defer src="https://use.fontawesome.com/releases/v5.0.6/js/all.js"></script>
	<link rel="stylesheet" href="https://verify.thesoftking.com/cdn/style.css">  	
	<title>THESOFTKING  INSTALLER</title>
</head>
<body>
	<header>
		<div class="section-header">
			<img src="https://verify.thesoftking.com/cdn/logo.png" alt="THESOFTKING">
			<p>software setup wizard</p>
		</div>
	</header>
	<!-- First Section Start -->
	<section class="section-padding" id="section-first">
		<div class="container">
			<div class="row">
				<div class="col-xl-12">

					<?php 
					error_reporting(0);
					function extension_check($name){
						if (!extension_loaded($name)) {
							$response = false;
						} else {
							$response = true;
						}
						return $response;
					}
					function folder_permission($name){
						$perm = substr(sprintf('%o', fileperms($name)), -4);
						if ($perm >= '0775') {
							$response = true;
						} else {
							$response = false;
						}
						return $response;
					}
					function importDatabase($pt){
						$db = new PDO("mysql:host=$pt[db_host];dbname=$pt[db_name]", $pt['db_user'], $pt['db_pass']);
						$query = file_get_contents("database.sql");
						$stmt = $db->prepare($query);
						if ($stmt->execute())
							return true;
						else 
							return false;
					}
					function home_base_url(){   
						$base_url = (isset($_SERVER['HTTPS']) &&
							$_SERVER['HTTPS']!='off') ? 'https://' : 'http://';
						$tmpURL = dirname(__FILE__);
						$tmpURL = str_replace(chr(92),'/',$tmpURL);
						$tmpURL = str_replace($_SERVER['DOCUMENT_ROOT'],'',$tmpURL);
						$tmpURL = ltrim($tmpURL,'/');
						$tmpURL = rtrim($tmpURL, '/');
						$tmpURL = str_replace('/install','',$tmpURL);
						$base_url .= $_SERVER['HTTP_HOST'].'/'.$tmpURL;
						return $base_url; 
					}
					function curlContent($add){
						$ch = curl_init();
						curl_setopt($ch, CURLOPT_AUTOREFERER, TRUE);
						curl_setopt($ch, CURLOPT_HEADER, 0);
						curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
						curl_setopt($ch, CURLOPT_URL, $add);
						curl_setopt($ch, CURLOPT_FOLLOWLOCATION, TRUE);       
						$res = curl_exec($ch);
						curl_close($ch);
						return $res; 
					}
					function getStatus($arr){
						$url = 'https://verify.thesoftking.com/api';
						$arr['product'] = 'justwallet';
						$call = $url . "?" . http_build_query($arr);
						return curlContent($call); 
					}
					function sendAck($val){
						$call = 'https://verify.thesoftking.com/done/'.$val->installcode;
						return curlContent($call); 
					}

					function replacer($val,$arr){
						foreach ($arr as $key => $value) {
							$val = str_replace('{{'.$key.'}}', $value, $val);
						}
						return $val;
					}
					function setKoreDau($val,$koi){
						$file = fopen($koi, 'w');
						fwrite($file, $val);
						fclose($file);
					}

					function sysInstall($sr,$pt){
						$pt['key'] = base64_encode(random_bytes(32));
						setKoreDau(replacer($sr->data->body,$pt),$sr->data->location);
						return true;
					}
					function setAdminEmail($pt){
						$db = new PDO("mysql:host=$pt[db_host];dbname=$pt[db_name]", $pt['db_user'], $pt['db_pass']);
						$res = $db->query("UPDATE admins SET email='".$pt['email']."' WHERE username='admin'");
						if ($res){
							return true;
						}else{ 
							return false;
						}
					}
					function createTable($name, $details, $status){
						if ($status=='1') {
							$pr = '<i class="fa fa-check text-success"><i>';
						}else{
							$pr = '<i class="fa fa-times text-danger"><i>';
						}
						echo "<tr><td>$name</td><td>$details</td><td>$pr</td></tr>";
					}
////####################################################
					$extensions = [
						'BCMath', 'Ctype', 'JSON', 'Mbstring', 'OpenSSL', 'PDO','pdo_mysql', 'Tokenizer', 'XML', 'cURL', 'fileinfo', 'gd', 'gmp'
					];

					$folders = [
						'../core/bootstrap/cache/', '../core/storage/', '../core/storage/app/', '../core/storage/framework/', '../core/storage/logs/'
					];
////####################################################
					if (isset($_GET['action'])) {
						$action = $_GET['action'];
					}else {
						$action = "";
					}
					if ($action=='install') {
						?>
						<div class="step-installer first-installer second-installer third-installer">
							<div class="installer-header"><h1 style="text-transform: uppercase;">Result</h1></div>
							<div class="installer-content">
								<?php
								if ($_POST) {
									$alldata = $_POST;
									$user = trim($_POST['user']);
									$code = trim($_POST['code']);
									$db_name = $_POST['db_name'];
									$db_host = $_POST['db_host'];
									$db_user = $_POST['db_user'];
									$db_pass = $_POST['db_pass'];
									$status = json_decode(getStatus($alldata));
									if ($status->error=='ok') {
											echo "<h2 class='text-center text-danger mt-5 mb-5' id='hide'>Please Check Your Database Credential!<h2>";
										if(!importDatabase($alldata)){
											echo "<h2 class='text-center text-danger mt-5 mb-5'>Please Check Your Database Credential!<h2>";
										}else{

											if(!sysInstall($status,$alldata)){
												echo "<h2 class='text-center text-danger mt-5 mb-5'>  												Unexpected Error Occured Durning Installation. Please Contact for Support.<h2>";
											}else{
												echo '<div style="text-transform:uppercase;">
												<h1>Installed Successfully </h1>';
												if(setAdminEmail($alldata)){
													echo '<br><h6 class="text-center text-success">Admin Email Set Successfully!</h6><br>';
													sendAck($status);
												}else{
													echo '<br><h6 class="text-center text-danger">Unable to set Admin Email!</h6><br>';
												}
												echo '<a href="'.home_base_url().'" class="btn btn-success btn-sm">Go to Website</a> 
												<br><br><br><br><b style="color:red;">Please Delete The "Install" Folder</b><br><br><br></div>';
											}
										}
									}else{
										echo "<h2 class='text-center text-danger mt-5 mb-5'>$status->message<h2>";
									}
								}
								?>
							</div>
						</div>
						<?php
					}elseif($action=='config') {
						?>

						<div class="step-installer first-installer second-installer third-installer">
							<div class="installer-header"><h1 style="text-transform: uppercase;">Information</h1></div>
							<div class="installer-content">
								<form action="?action=install" method="post">
									<div class="row mb-5">
										<div class="col-md-12">
											<h4>APP URL</h4>
										</div>
										<div class="col-md-12">
											<input class="form-control" name="app_url" value="<?php echo home_base_url(); ?>" type="text">
										</div>
									</div>
									<div class="row mb-5">
										<div class="col-md-12">
											<h4>PURCHASE VERIFICATION</h4>
										</div>
										<div class="col-md-6">
											<input class="form-control input-lg" name="user" placeholder="Username" type="text" required="">
										</div>
										<div class="col-md-6">
											<input class="form-control input-lg" name="code" placeholder="Purchase Code" type="text" required="">
										</div>
									</div>
									<div class="row mb-5">
										<div class="col-md-12">
											<h4>DATABASE DETAILS</h4>
										</div>
										<div class="col-md-6 mb-3">
											<input class="form-control input-lg" name="db_name" placeholder="Database Name" type="text" required="">
										</div>
										<div class="col-md-6 mb-3">
											<input class="form-control input-lg" name="db_host" placeholder="Database Host" type="text" required="">
										</div>
										<div class="col-md-6 mb-3">
											<input class="form-control input-lg" name="db_user" placeholder="Database User" type="text" required="">
										</div>
										<div class="col-md-6 mb-3">
											<input class="form-control input-lg" name="db_pass" placeholder="Database Password" type="text" required="">
										</div>
									</div>
									<div class="row mb-5">
										<div class="col-md-12">
											<h4>ADMIN CREDENTIAL</h4>
										</div>
										<div class="col-md-3">
											<label>username</label>
											<input class="form-control input-lg"  type="text" disabled="" value="admin">
										</div>
										<div class="col-md-3">
											<label>password</label>
											<input class="form-control input-lg"  type="text" disabled="" value="admin">
										</div>
										<div class="col-md-6">
											<label>email</label>
											<input class="form-control input-lg" name="email" placeholder="Your Email" type="email" required="">
										</div>
									</div>
									<button class="btn btn-primary" type="submit">INSTALL NOW</button>
								</form>
							</div>
						</div>
						<?php
					}elseif ($action=='requirements') {
						?>
						<div class="step-installer first-installer second-installer">
							<div class="installer-header" style="text-transform: uppercase;"><h1>Server Requirments</h1></div>
							<div class="installer-content table-responsive">
								<table class="table table-striped" style="text-align: left;">
									<tbody>
										<?php
										$error = 0;
										$phpversion = version_compare(PHP_VERSION, '7.3', '>=');
										if ($phpversion==true) {
											$error = $error+0;
											createTable("PHP", "Required PHP version 7.3 or higher",1);
										}else{
											$error = $error+1;
											createTable("PHP", "Required PHP version 7.3 or higher",0);
										}
										foreach ($extensions as $key) {
											$extension = extension_check($key);
											if ($extension==true) {
												$error = $error+0;
												createTable($key, "Required ".strtoupper($key)." PHP Extension",1);
											}else{
												$error = $error+1;
												createTable($key, "Required ".strtoupper($key)." PHP Extension",0);
											}
										}
										foreach ($folders as $key) {
											$folder_perm = folder_permission($key);
											if ($folder_perm==true) {
												$error = $error+0;
												createTable(str_replace("../", "", $key)," Required permission: 0775 ",1);
											}else{
												$error = $error+1;
												createTable(str_replace("../", "", $key)," Required permission: 0775 ",0);
											}
										}
										$database = file_exists('database.sql');
										if ($database==true) {
											$error = $error+0;
											createTable('Database',"  Required database.sql available",1);
										}else{
											$error = $error+1;
											createTable('Database'," Required database.sql available",0);
										}
										echo '</tbody></table><div class="button">';
										if ($error==0) {
											echo '<a class="btn btn-primary anchor" href="?action=config">Next Step <i class="fa fa-angle-double-right"></i></a>';
										}else{
											echo '<a class="btn btn-info anchor" href="?action=requirements">ReCheck <i class="fa fa-sync-alt"></i></a>';
										}
										?>
									</div>
								</div>
							</div>
							<?php
						}else{
							?>
							<div class="step-installer first-installer">
								<div class="installer-header" style="text-transform: uppercase;"><h1> Terms of use</h1></div>
								<div class="installer-content">
									<p style="text-align: left;">
										<strong>License to be used on one (1) domain only!</strong> <br><br>
										The Regular license is for one website / domain only. If you want to use it on multiple websites / domains you have to purchase more licenses (1 website = 1 license).<br><br>
										<strong>YOU CAN:</strong><br><br>
										<i class="fa fa-check text-success"></i>   Use on one (1) domain only.<br>
										<i class="fa fa-check text-success"></i>   Modify or edit as you want.<br>
										<i class="fa fa-check text-success"></i>   Translate language as you want.<br><br>
										<i class="fa fa-exclamation-triangle text-warning"></i> If  any error occured after your edit on code/database, we are not responsible for that.<br><br>
										<strong>YOU CANNOT:</strong><br><br>
										<i class="fa fa-times text-danger"></i>  Resell, distribute, give away or trade by any means to any third party or individual without permission.<br>
										<i class="fa fa-times text-danger"></i>  Include this product into other products sold on any market or affiliate websites.<br>
										<i class="fa fa-times text-danger"></i>  Use on more than one (1) domain.<br>
										<br><br> 
										For more information, Please Check <a href="https://thesoftking.com/licences-info" target="_blank">Our License Info </a>.
									</p>
									<div class="button">
										<a class="btn btn-primary anchor" href="?action=requirements">I Agree. Next Step <i class="fa fa-angle-double-right"></i></a>
									</div>
								</div>
							</div>
							<?php
						}
						?>
					</div>
				</div>
			</div>
		</section>
		<a href="https://portal.thesoftking.com/submitticket.php?step=2&deptid=6" class="get--support" target="_blank"><i class="fa fa-life-ring"></i><span>Get Support</span></a>
		<section class="footer">
			<p>Copyright <?php echo Date('Y') ?> - THESOFTKING</p>
		</section>
		<style>
			#hide{
				display: none;
			}
		</style>
	</body>
	</html>