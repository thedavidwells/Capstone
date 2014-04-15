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
    var course = new CourseModel();
    course.setTitle('Untitled Course');
    var CourseCollection = Parse.Collection.extend({
      model: LessonModel,
      className:'Lesson',
    });
    var myCourses = new CourseCollection();
    myCourses.query = new Parse.Query('Course');
    myCourses.query.equalTo('Author', currentUser);
    
    // Public API here
    return {
      logout: function(){
        return Parse.User.logOut();
      },
      newLesson: function(){
        return {title: '', description: '', initialText:'', sublessons:[]};
      },
      getCourses: function () {
        return myCourses.fetch()
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
        return c.save(null);
      }
    };
  });
