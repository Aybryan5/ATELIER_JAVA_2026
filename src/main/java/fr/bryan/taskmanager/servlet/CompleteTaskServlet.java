package fr.bryan.taskmanager.servlet;

import fr.bryan.taskmanager.model.Task;
import fr.bryan.taskmanager.util.TaskSession;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

public class CompleteTaskServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String id = request.getParameter("id");
        ArrayList<Task> tasks = TaskSession.getTasks(request.getSession());
        Task task = TaskSession.findById(tasks, id);

        if (task != null) {
            task.setCompleted(!task.isCompleted());
        }

        response.sendRedirect(request.getContextPath() + "/tasks.jsp?updated=true");
    }
}
