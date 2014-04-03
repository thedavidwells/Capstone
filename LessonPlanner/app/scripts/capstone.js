function finishLoading(){
	$("#ajax_loader").fadeOut();
}
function startLoading(){
	$("#ajax_loader").fadeIn();	
}

$(function(){
	Parse.$ = $;
	Parse.initialize('29wOKycz8F6JaRXHNttPXiynbGOFKUqOYAZvKZVc',
                   '4iNIqeEGthAqjMAhYRIz5JVF1hKDnsTBDCPomf5o');

	//////////////////////////////////////////////////////////////
	/// Objects
	//////////////////////////////////////////////////////////////
	var Course = Parse.Object.extend('Course', {}, {
		Create: function(){
			var c = new Course();
			c.set('Author', Parse.User.current());
			return c;
		}
	});
	var Lesson = Parse.Object.extend('Lesson');
	var Step = Parse.Object.extend('Step');

	var Profile = Parse.Object.extend('Profile', {},{
		Create: function(){
			var c = new Profile();
			c.set('User', Parse.User.current());
			return c;
		}
	});



	//var query = new Parse.Query(Course);
	//query.equalTo("Author", Parse.User.current());
	//query.find({
	//	success: function(results){
	//		console.log("RESULTS",JSON.stringify(results));
	//	}
	//})

	//////////////////////////////////////////////////////////////
	/// Collections
	//////////////////////////////////////////////////////////////


	var Courses = Parse.Collection.extend({
		Model: Course
	});

	var Lessons = Parse.Collection.extend({
		Model: Lesson
	});

	var Steps = Parse.Collection.extend({
		Model: Step
	});

	//////////////////////////////////////////////////////////////
	/// Views
	//////////////////////////////////////////////////////////////
	
	


	var SelectCourseView = Parse.View.extend({
		events: {
			'click .newCourseButton': 'newCourse'
		},
		courses: new Courses(),
		el: '.content',
		initialize: function() {

			this.render();
			_.bindAll(this, 'newCourse');
		},
		render: function(){
			this.$el.html(_.template($('#SelectCourseView').html()));
			new CourseDropdownView({courses: this.courses});
		},
		newCourse: function(){
			var course = new Course.Create();
			this.courses.add(course);
			new CourseView({model: course});
		}
	});
	var CourseDropdownView = Parse.View.extend({
		el: '#CourseSelector',
		initialize: function(ops){
			this.courses = ops.courses;
			this.render();
		},
		render: function(){
			$(this.$el).html(_.template($('#CourseDropdownTemplate').html(), {Courses: this.courses.toJSON()}));
		}
	});
	var CourseView = Parse.View.extend({
		events: {
			'click #newLesson': 'newLesson'
		},
		el:('.content'),
		template: _.template($('#CourseTemplate').html()),
		initialize: function(opts){
			this.render();
			console.log(this.model.toJSON());
			//console.log(this.course.toJSON());
		},
		render: function(){
			this.$el.html(this.template({Course: this.model}));
		},
		newLesson: function(){
			var that = this;
			var l = new Lesson();
			startLoading();
			l.save(null, {
				success: function(){
					var arr = that.model.get('Lessons') || [];
					arr.push(l.id);
					that.model.set('Lessons', arr);
					that.model.save(null, {
						success: function(){
							console.log('saved lesson');
							finishLoading();
						}
					});
					new LessonView({model: l, lessonNumber: that.model.get('Lessons').length, el: '#lessons' });
				},
				error: function(){
					alert('error');
					finishLoading();
				}
			});
		}
	});



	var LessonView = Parse.View.extend({
		events: {},
		tag:'li',
		newStep: function(){
			var s = new Step();
			s.save(null, {
				success: function(){
					this.model.steps.push()
				}
			})
			new StepView({
				el:'#steps-'+this.lessonNumber,
				step: s,
				lessonNumber: this.lessonNumber
			});

		},
		template: _.template($('#LessonTemplate').html()),
		initialize: function(){
			this.lessonNumber = this.options.lessonNumber;
			this.undelegateEvents();
			this.events['click #newStep-'+this.options.lessonNumber] = this.newStep;
			this.delegateEvents();
			//this.lesson = this.options.lesson;
			this.render();
			_.bindAll(this, 'newStep');
		},
		render: function(){
			this.$el.append(this.template({
				Lesson: this.model,
				lessonNumber: this.lessonNumber
			}));
		}
	});

	var StepView = Parse.View.extend({
		template: _.template($('#StepTemplate').html()),
		initialize: function(){
			console.log(this);
			this.step = this.options.step;
			// this.$el = $('#steps-'+ops.lessonNumber);
			console.log("initialize:", this.options.lessonNumber, this.el);
			this.render();
		},
		render: function(){
			this.$el.append(this.template({Step: this.step}));
			// console.log("scrollTo: ", this.$el)
			// scrollTo($(this.$el));
		}
	});


	var LogInView = Parse.View.extend({
		events: {
			'submit form.login-form': 'logIn',
			'submit form.signup-form': 'signUp',
			'click .login-button': 'logIn',
			'click .register-button': 'signUp',
		},

		el: '.content',

		initialize: function() {
			_.bindAll(this, 'logIn', 'signUp');
			this.render();
		},

		logIn: function() {
			var self = this;
			var username = this.$('#login-username').val();
			var password = this.$('#login-password').val();

			Parse.User.logIn(username, password, {
				success: function() {
					new SelectCourseView();
					new LoginInfo();
					var query = new Parse.Query(Profile);
					query.equalTo('User', Parse.User.current().id);
					console.log("searching for user", Parse.User.current().id)
					query.find({
						success:function(results){
							results = results || [];
							console.log("go profile results: ", results);
							if(results.length < 1){
								console.log("saving new profile");
								Profile.Create().save({
									success: function(profile){
										Parse.User.Profile = profile;
									}
								});
								
							} else {
								Parse.User.Profile = results[0];
							}
						},
						failure: function(){
							
						}
					})
					self.undelegateEvents();
				},

				error: function() {
					$('.login-form .error').html('Invalid username or password. Please try again.').show();
					$('.login-form button').removeAttr('disabled');
				}
			});

			this.$('.login-form button').attr('disabled', 'disabled');

			return false;
		},

		signUp: function() {
			var self = this;
			var username = this.$('#signup-username').val();
			var password = this.$('#signup-password').val();

			Parse.User.signUp(username, password, { ACL: new Parse.ACL() }, {
				success: function() {
					var profile = new Profile.create().save({
						success: function(){
							new SelectCourseView();
							new LoginInfo();
							self.undelegateEvents();		
						}
					});
					
				},

				error: function(user, error) {
					console.log(error);
					$('.signup-form .error').html(error.message).show();
					$('.signup-form button').removeAttr('disabled');
				}
			});

			this.$('.signup-form button').attr('disabled', 'disabled');

			return false;
		},

		render: function() {
			this.$el.html(_.template($('#login-template').html()));
			this.delegateEvents();
		}
	});

	var LoginInfo = Parse.View.extend({
		events: {
			'click .logout': 'logOut'
		},
		el: '#loginInfo',
		initialize: function(){
			this.render();
			_.bindAll(this, 'logOut');
		},
		render: function(){
			this.$el.html
			(
					_.template(
						$('#loginInfoTemplate').html(), {user: Parse.User.current()}
					)
				);
		},
		// Logs out the user and shows the login view
		logOut: function() {
			Parse.User.logOut();
			this.$el.html('');
			new LogInView();
			this.undelegateEvents();
		},
	});




	if(!Parse.User.current()){
		new LogInView();
	} else {
		new SelectCourseView();
		new LoginInfo();
	}
})