'use strict';

angular.module('lessonPlannerApp')
  .factory('parseWrapper', function () {
    var currentUser = Parse.User.current();
    var LessonModel = Parse.Object.extend({
      className: 'Lesson',
      attrs: ['title', 'Author', 'description', 'goal', 'lessons']
    });
    var CourseModel = Parse.Object.extend({
      className: 'Course',
      attrs: ['title', 'Author', 'description', 'goal', 'lessons', 'enrollId', 'enrollPassword' ]
    });
    // var course = new CourseModel();
    // course.setTitle('Untitled Course');
    var CourseCollection = Parse.Collection.extend({
      model: CourseModel,
      className:'Lesson',
    });
    var myCourses = new CourseCollection();
    myCourses.query = new Parse.Query('Course');
    myCourses.query.equalTo('Author', currentUser);

    // var school = new SchoolModel();
    // school.setTitle('Untitled School');
    
    var UsersModel = Parse.Object.extend({
      className:'User',
      attrs: ['username', 'courses']
    });
    var AllUsersCollection = Parse.Collection.extend({
      model: UsersModel,
      className: 'User'
    });
    var allUsers = new AllUsersCollection();
    allUsers.query = new Parse.Query('User');

    // Public API here
    return {
      getStudents: function(){
        return allUsers.fetch();
      },
      getStudent: function(id){
        return allUsers.fetch().then(function(){
          return allUsers.get(id);
        });
      },
      logout: function(){
        return Parse.User.logOut();
      },
      newLesson: function(){
        return {title: '', description: '', initialText:'', sublessons:[]};
      },
      getCourses: function () {
        return myCourses.fetch()
      },
      getSchools: function () {
        return mySchools.fetch()
      },
      getCourse: function(id){
        return myCourses.fetch()
        .then(function(){
          return myCourses.get(id);
        },function(e){
          console.warn('error', e);
        });
      },
      createCourse:function(){
        var c = new CourseModel();
        c.setTitle('New Title');
        c.setAuthor(currentUser);
        c.setEnrollId(Math.random().toString(36).slice(2, 10).toLowerCase());
        c.setEnrollPassword(Math.random().toString(36).slice(2, 10).toLowerCase());
        var groupACL = new Parse.ACL();
        groupACL.setWriteAccess(currentUser, true);
        groupACL.setPublicReadAccess(true);
        c.setACL(groupACL);
        return c.save(null);
      },
      destroyCourse: function(course){
        return course.destroy();
      }
    };
  });
