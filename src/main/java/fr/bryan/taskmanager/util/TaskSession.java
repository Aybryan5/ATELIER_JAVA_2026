package fr.bryan.taskmanager.util;

import fr.bryan.taskmanager.model.Task;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

public final class TaskSession {
    public static final String TASKS_ATTRIBUTE = "tasks";

    private TaskSession() {
    }

    @SuppressWarnings("unchecked")
    public static ArrayList<Task> getTasks(HttpSession session) {
        Object value = session.getAttribute(TASKS_ATTRIBUTE);
        if (value instanceof ArrayList<?>) {
            return (ArrayList<Task>) value;
        }

        ArrayList<Task> tasks = new ArrayList<>();
        session.setAttribute(TASKS_ATTRIBUTE, tasks);
        return tasks;
    }

    public static Task findById(List<Task> tasks, String id) {
        if (id == null) {
            return null;
        }

        for (Task task : tasks) {
            if (id.equals(task.getId())) {
                return task;
            }
        }
        return null;
    }
}
