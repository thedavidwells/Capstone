'use strict';

angular.module('lessonPlannerApp')
  .factory('parseWrapper', function () {
    var currentUser = Parse.User.current();
    var LessonModel = Parse.Object.extend({
      className: 'Lesson',
      attrs: ['title', 'Author', 'description', 'goal', 'steps']
    });
    var lesson = new LessonModel();
    lesson.setTitle('new lesson');
    var LessonCollection = Parse.Collection.extend({
      model: LessonModel,
      className:'Lesson',

    });
    var myLessons = new LessonCollection();
    myLessons.query = new Parse.Query('Lesson');
    myLessons.query.equalTo('Author', currentUser);
    
    var StepModel = Parse.Object.extend({
      className: 'Step',
      attrs: ['title', 'description', 'hints', 'initialText', 'goal']
    });
    // Public API here
    return {
      getLessons: function () {
        return myLessons.fetch()
      },
      getLesson: function(id){
        return myLessons.fetch()
        .then(function(){
          return myLessons.get(id);
        },function(e){
          console.warn('error', e);
        });
      },
      logout: function(){
        return Parse.User.logOut();
      },
      createLesson:function(){
        var l = new LessonModel();
        l.setTitle('New Title');
        l.setAuthor(currentUser);
        return l.save(null);
      },
      newStep: function(){
        return {title: '', description: '', goal:'', initialText:'', hints:[]};
      },
      stepFromObject: function(obj){
        var s = new StepModel();
        s.set(obj);
        return s;
      }

    };
  });
