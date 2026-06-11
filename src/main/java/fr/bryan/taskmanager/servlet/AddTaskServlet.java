package fr.bryan.taskmanager.servlet;

import fr.bryan.taskmanager.model.Task;
import fr.bryan.taskmanager.util.TaskSession;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;

public class AddTaskServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String title = normalize(request.getParameter("title"));
        String description = normalize(request.getParameter("description"));
        String dueDateValue = normalize(request.getParameter("dueDate"));

        if (title.isEmpty() || description.isEmpty() || dueDateValue.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/add-task.jsp?error=missing");
            return;
        }

        LocalDate dueDate;
        try {
            dueDate = LocalDate.parse(dueDateValue);
        } catch (DateTimeParseException exception) {
            response.sendRedirect(request.getContextPath() + "/add-task.jsp?error=date");
            return;
        }

        ArrayList<Task> tasks = TaskSession.getTasks(request.getSession());
        tasks.add(new Task(title, description, dueDate));

        response.sendRedirect(request.getContextPath() + "/tasks.jsp?added=true");
    }

    private String normalize(String value) {
        return value == null ? "" : value.trim();
    }
}
