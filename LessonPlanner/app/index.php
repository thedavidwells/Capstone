<!doctype html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->
<head>
    <meta charset="utf-8">
    <title>LessonPlanner</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width">
    <link rel="shortcut icon" href="/favicon.ico">
    <!-- Place favicon.ico and apple-touch-icon.png in the root directory -->
    <!-- build:css styles/vendor.css -->
    <!-- bower:css -->
    <link rel="stylesheet" href="bower_components/bootstrap/dist/css/bootstrap.min.css">
    <!-- endbower -->
    <!-- endbuild -->
    <!-- build:css(.tmp) styles/main.css -->
    <link rel="stylesheet" href="styles/main.css">
    <!-- endbuild -->
</head>
<body>
        <!--[if lt IE 10]>
            <p class="browsehappy">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
            <![endif]-->
            <div id='header' class="header navbar-fixed-top">
                <div class='container'>
                    <ul class="nav nav-pills pull-right">
                        <li class="active" ><a target='#startPlanning' href="#">Course Planning</a></li>
                        <li><a href="#documentation" target='#documentation'>Documentation</a></li>
                        <li><a href="#contact" target='#contact'>Contact</a></li>
                    </ul>
                    <h3 class="text-muted">Capstone Lesson Planner</h3>
                    <div id='loginInfo'></div>
                </div>
            </div>
            <div class="container">
                <div class='fullscreen row' id='startPlanning'>
                    <div id="content" class="content">
                    </div>
                </div>



                <div class="fullscreen" id='documentation'>
                    <h4 > <a name="documentation"></a>Documentation</h4>
                    <p>TODO: Add documentation.</p>
                </div>
                <div class='fullscreen' id='contact'>
                    <h4 > <a name="contact"></a>Contact Us</h4>
                    <p>TODO: Add our contact information.</p>
                </div>

                <div class="footer">
                    <p><span class="glyphicon glyphicon-tower"></span> Created By: Steve Kyles, David Wells, and Eric Wooley </p>
                </div>

            </div>


            <!-- build:js scripts/vendor.js -->
            <!-- bower:js -->
            <script src="bower_components/jquery/dist/jquery.js"></script>
            <!-- endbower -->
            <!-- endbuild -->

        <!-- Google Analytics: change UA-XXXXX-X to be your site's ID. 
        <script>
            (function(b,o,i,l,e,r){b.GoogleAnalyticsObject=l;b[l]||(b[l]=
            function(){(b[l].q=b[l].q||[]).push(arguments)});b[l].l=+new Date;
            e=o.createElement(i);r=o.getElementsByTagName(i)[0];
            e.src='//www.google-analytics.com/analytics.js';
            r.parentNode.insertBefore(e,r)}(window,document,'script','ga'));
            ga('create','UA-XXXXX-X');ga('send','pageview');
        </script>
    -->
    <!-- build:js scripts/plugins.js -->
    <script src="bower_components/bootstrap/js/affix.js"></script>
    <script src="bower_components/bootstrap/js/alert.js"></script>
    <script src="bower_components/bootstrap/js/dropdown.js"></script>
    <script src="bower_components/bootstrap/js/tooltip.js"></script>
    <script src="bower_components/bootstrap/js/modal.js"></script>
    <script src="bower_components/bootstrap/js/transition.js"></script>
    <script src="bower_components/bootstrap/js/button.js"></script>
    <script src="bower_components/bootstrap/js/popover.js"></script>
    <script src="bower_components/bootstrap/js/carousel.js"></script>
    <script src="bower_components/bootstrap/js/scrollspy.js"></script>
    <script src="bower_components/bootstrap/js/collapse.js"></script>
    <script src="bower_components/bootstrap/js/tab.js"></script>
    <script src="bower_components/underscore/underscore.js"></script>

    <!-- endbuild -->

    <!-- build:js({app,.tmp}) scripts/main.js -->
    <script src="scripts/parse-1.2.18.js"></script>
    <script src="scripts/main.js"></script>
    <script src="scripts/capstone.js"></script>
    <!-- endbuild -->
    <!-- Templates -->
    <script type="text/template" id="login-template">
      <header id="header"></header>
      <div class="login col-xs-12">
        <form class="login-form">
            <h2>Log In</h2>
            <div class="error" style="display:none"></div>
            <div class='input-group'>
                <span class="input-group-addon">Username</span>
                <input type="text" class='form-control' id="login-username" placeholder="Username" />
            </div>
            <div class='input-group'>
                <span class="input-group-addon">Password</span>
                <input type="password" class='form-control' id="login-password" placeholder="Password" />
            </div>
            <p>
                <a class="btn btn-lg btn-success login-button" style='width: 100%'>Log in</a>
            </p>
        </form>
        <hr />
        <form class="signup-form">
            <h2>Sign Up</h2>
            <div class="error" style="display:none"></div>
            <div class='input-group'>
                <span class="input-group-addon">Username</span>
                <input type="text" class='form-control' id="signup-username" placeholder="Username" />
            </div>
            <div class='input-group'>
                <span class="input-group-addon">Password</span>
                <input type="password" class='form-control' id="signup-password" placeholder="Password" />
            </div>
            <p>
                <a class="btn btn-lg btn-success register-button" style='width: 100%'>Sign Up</a>
            </p>
        </form>
</div>
</script>



<script type="text/template" id="getStartedTemplate">
    <div class='row'>
        <div class='col-xs-12'>
        <h1>Capstone Lesson Planner</h1>
        <p class="lead">Generate lessons to use in your classroom.</p>
        </div>
    </div>
    <div class='row'>
        <div class='col-lg-7' id='LessonSelector'>
            
        </div>
        <div class='col-lg-5'>
            <a 
            class="btn btn-lg btn-success newLessonButton pull-right"
            id='getStarted'
            href="#" >
                Create new Lesson <span class="glyphicon glyphicon-pencil " />
            </a>
        </div>
     </div>
 </script>
<script type="text/template" id='LessonSelectorTemplate'>
    <select style="margin-top: 10px" class="form-control">
        <% if(Lessons.length > 0) { _.each(Lessons, function(lesson){%>
            <option><%= lesson.get('title') %></option>
        <% }); } else { %>
            <option>No lessons have been created</option>
        <% } %>
    </select>
</script>
 <script type="text/template" id="LessonTemplate">
     <div class='row'>       
        <div>
            <div class='col-xs-12'>
                <div class='input-group'>
                    <span class="input-group-addon">Lesson Title</span>
                    <input name="courseTitle" id="courseTitle" class="form-control" placeholder="Enter in a title for your course. Example: Algebra 1" type="text" />
                </div>
            </div>
        </div>
    </div>
</script>

<script type="text/template" id='loginInfoTemplate'>
    <span>
        <% if(user) { %>
            <%= user.get('username') %>
            <a href="#" class='logout' > logout? </a> 
        <% } %>
    </span>
</script>
<script type="text/template" id="lessonTemplate">
    <div class='input-group'>
        <span class="input-group-addon">Lesson Title</span>
        <input name="lessonTitle" class="form-control" placeholder="Algebra 1" type="text" />
    </div>
    <div class='input-group'>
        <span class="input-group-addon">Lesson Description</span>
        <input name="lessonDescription" class="form-controls" placeholder="Learn to balance equations" type="text" />
    </div>
</script>
</body>
</html>