package com.example.matin_noohnezhad_assignment_2.activities;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.example.matin_noohnezhad_assignment_2.R;
import com.example.matin_noohnezhad_assignment_2.database.asyn_tasks.DeleteTaskAsyncTask;
import com.example.matin_noohnezhad_assignment_2.database.asyn_tasks.UpdateTaskAsyncTask;
import com.example.matin_noohnezhad_assignment_2.task.Task;
import com.example.matin_noohnezhad_assignment_2.task.TaskAdapter;
import com.example.matin_noohnezhad_assignment_2.task.TaskClickListener;
import com.example.matin_noohnezhad_assignment_2.utils.TaskListHolder;

import java.util.List;

public class PageDueTasks extends AppCompatActivity implements TaskClickListener {

    private TaskAdapter taskAdapter;
    private RecyclerView recyclerView;
    private static List<Task> dueTasks;
    private int deleteTaskPosition;
    private int changeStatusTaskPosition;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.due_tasks_page);

        recyclerView = findViewById(R.id.recycler_view_1);
        setUpRecyclerView();
    }

    private void setUpRecyclerView() {
        taskAdapter = new TaskAdapter(this, TaskListHolder.getDueTaskList(), this, true);
        recyclerView.setLayoutManager(new LinearLayoutManager(this));
        recyclerView.setAdapter(taskAdapter);
    }

    public void addTask(View view) {
        Context context = getApplicationContext();
        Intent intent = new Intent(context, NewTaskActivity.class);
        startActivity(intent);
    }

    @Override
    public void onTaskDelete(int position) {
        deleteTaskPosition = position;
        DeleteTaskAsyncTask dtat = new DeleteTaskAsyncTask(this);
        dtat.execute(taskAdapter.getTaskIdByPosition(position));
    }

    public void afterTaskDeleteFromDB() {
        taskAdapter.removeItem(deleteTaskPosition);
        //
        Context context = getApplicationContext();
        CharSequence text = "Task has been deleted!!!";
        int duration = Toast.LENGTH_SHORT;
        Toast toast = Toast.makeText(context, text, duration);
        toast.show();
    }

    @Override
    public void onTaskChangeStatus(int position) {
        changeStatusTaskPosition = position;
        UpdateTaskAsyncTask utat = new UpdateTaskAsyncTask(this);
        utat.execute(taskAdapter.getTaskByPosition(position));
    }

    public void afterTaskChangeStatus() {
        Task t = taskAdapter.removeItem(changeStatusTaskPosition);
        TaskListHolder.addToArchivedTasks(t);
        //
        Context context = getApplicationContext();
        CharSequence text = "Task has been moved to archived tasks!!!";
        int duration = Toast.LENGTH_SHORT;
        Toast toast = Toast.makeText(context, text, duration);
        toast.show();
    }
}
