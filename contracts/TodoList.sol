 // SPDX-License-Identifier: MIT
 pragma solidity 0.8.24;

 contract TodoList {

    struct ToDo {
        string text;
        bool completed;
    }
    ToDo[] public todos;

    function create (string calldata _text  ) external  {
        todos.push(ToDo({text:_text ,completed:false}) );

    }

    function updateText (string calldata _text ,uint _index) external {
        todos[_index].text = _text;

    }
    function updateText2 (string calldata _text ,uint _index) external {
        //结构体中有多个字段时，使用storage将变量取出来，然后批量给各个字段赋值，会比直接使用索引先查询再赋值节省gas
        todos[_index].text = _text;
        ToDo storage todo = todos[_index];
        todo.text = _text;


    }

    function toggleCompleted(uint _index) external {
        todos[_index].completed = !todos[_index].completed;
    }
 }