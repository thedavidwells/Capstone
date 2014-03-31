$(function(){
	Parse.$ = $;
	Parse.initialize('29wOKycz8F6JaRXHNttPXiynbGOFKUqOYAZvKZVc',
                   '4iNIqeEGthAqjMAhYRIz5JVF1hKDnsTBDCPomf5o');
	$.ajaxPrefilter(function(options, originalOptions, jqXHR){
		console.log("SETUP REQUEST");
		jqXHR.setRequestHeader('Access-Control-Allow-Origin', '*');
	});
	var Lesson = Parse.Object.extend('Lesson', {
		defaults: {
			Title: 'Lesson Title',
			Rating: 0,
			Description: 'Lesson Description',
			Author: 'Author Name',
			Goal: 'The Goal of this lesson',
			AttemptCount: 0,
			MaxAttempts: 0,
			Score: 0,
			SubLessons:{
				Title: 'Sub Lesson Title',
				SubLessonGoal: 'The goal of this sublesson',
				Steps: [
					{
						GoalOfStep: 'Step Goal',
						ExpectedResult: 10,
						Hints: [
							'hint 1',
							'hint 2'
						],
						Goal: 'Step Goal',
						Status: 'unstarted',
						Initialtext: 'This is the text you want them to start with.'
					}
				]
			}
		}
	});
	var Lessons = Parse.Collection.extend({
		Model: Lesson
	});


	var LessonView = Parse.View.extend({
		el:('.content'),
		template: _.template($('#LessonTemplate').html()),
		initialize: function(){
			
			this.render();
		},
		render: function(){
			this.$el.html(this.template({Lesson: this.model}));
		}
	});
	var LessonSelectorView = Parse.View.extend({
		el: '#LessonSelector',
		initialize: function(ops){
			this.lessons = ops.lessons;
			this.render();
		},
		render: function(){
			$(this.$el).html(_.template($('#LessonSelectorTemplate').html(), {Lessons: this.lessons.toJSON()}));
		}
	});
	var GetStartedView = Parse.View.extend({
		events: {
			'click .newLessonButton': 'newLesson'
		},
		lessons: new Lessons(),
		el: '.content',
		initialize: function() {

			this.render();
			_.bindAll(this, 'newLesson')
		},
		render: function(){
			this.$el.html(_.template($('#getStartedTemplate').html()));
			new LessonSelectorView({lessons: this.lessons});
		},
		newLesson: function(){
			var lesson = new Lesson();
			this.lessons.add(lesson);
			new LessonView({model: lesson});
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
					new GetStartedView();
					new LoginInfo();
					self.undelegateEvents();
					delete self;
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
					new GetStartedView();
					new LoginInfo();
					self.undelegateEvents();
					delete self;
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
			delete this;
		},
	});
	if(!Parse.User.current()){
		new LogInView();
	} else {
		new GetStartedView();
		new LoginInfo();
	}
})