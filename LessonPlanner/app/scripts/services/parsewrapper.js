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
      attrs: ['title', 'Author', 'description', 'goal', 'lessons']
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

    var SchoolModel = Parse.Object.extend({
      className: 'School',
      attrs: ['title', 'Admin', 'description', 'goal', 'students', 'studentAccessCode', 'teacherAccessCode']
    });
    // var school = new SchoolModel();
    // school.setTitle('Untitled School');
    var SchoolCollection = Parse.Collection.extend({
      model: SchoolModel,
      className:'Lesson',
    });
    var mySchools = new SchoolCollection();
    mySchools.query = new Parse.Query('School');
    mySchools.query.equalTo('Admin', currentUser);
    mySchools.query.include(['students', 'teachers']);
    var allSchools = new SchoolCollection();
    allSchools.query = new Parse.Query('School');
    
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
        var groupACL = new Parse.ACL();
        groupACL.setWriteAccess(currentUser, true);
        groupACL.setPublicReadAccess(true);
        c.setACL(groupACL);
        return c.save(null);
      },
      destroyCourse: function(course){
        return course.destroy();
      },
      createSchool:function(){
        var s = new SchoolModel();
        s.setTitle('New School');
        s.setAdmin(currentUser);
        s.setStudentAccessCode(Math.random().toString(36).slice(2).toLowerCase());
        s.setTeacherAccessCode(Math.random().toString(36).slice(2).toLowerCase());

        var groupACL = new Parse.ACL();
        groupACL.setWriteAccess(currentUser, true);
        groupACL.setPublicReadAccess(true);
        s.setACL(groupACL);
        return s.save(null);
      },
      getSchool: function(id){
        return mySchools.fetch()
        .then(function(){
          return mySchools.get(id);
        },function(e){
          console.warn('error', e);
        });
      },
      allSchools: function(){
        return allSchools.fetch();
      }
    };
  });
