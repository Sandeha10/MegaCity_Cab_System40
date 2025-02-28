@WebServlet("/BookingServlet")
public class BookingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String customerName = request.getParameter("name");
        String address = request.getParameter("address");
        String nic = request.getParameter("nic");
        String contact = request.getParameter("contact");
        String pickupLocation = request.getParameter("pickupLocation");
        String dropLocation = request.getParameter("dropLocation");
        String date = request.getParameter("date");
        String time = request.getParameter("time");
        String vehicleType = request.getParameter("vehicleType");
        String vehicleModel = request.getParameter("vehicleModel");

        // Generate booking reference number (e.g., booking ref + current timestamp)
        String bookingRef = "BOOK-" + System.currentTimeMillis();

        BookingDAO bookingDAO = new BookingDAO();
        bookingDAO.saveBooking(customerName, address, nic, contact, pickupLocation, dropLocation, date, time, vehicleType, vehicleModel, bookingRef);

        response.sendRedirect("customer/dashboard.jsp");
    }
}
