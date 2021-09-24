package com.example.demo;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;

import com.example.demo.models.Category;
import com.example.demo.models.Order;
import com.example.demo.models.Product;
import com.example.demo.models.User;
import com.example.demo.repositories.CategoryRepository;
import com.example.demo.repositories.OrderDetailRepository;
import com.example.demo.repositories.OrderRepository;
import com.example.demo.repositories.ProductRepository;
import com.example.demo.repositories.UserRepository;

@Controller
public class MyController {

	@Autowired
	private UserRepository userRepository;

	@Autowired
	private CategoryRepository categoryRepository;

	@Autowired
	private ProductRepository productRepository;

	@Autowired
	private OrderRepository orderRepository;

	@Autowired
	private OrderDetailRepository orderDetailRepository;

	// login page
	@GetMapping(path = "/login")
	public String viewLogin(HttpSession session, HttpServletResponse response) throws IOException {
		if (session.getAttribute("userName") != null) {
			response.sendRedirect("dashboard");
			return "login";
		}
		return "login";
	}

	// logout page
	@PostMapping(path = "/logout")
	public String logout(HttpSession session, HttpServletResponse response) throws IOException {
		session.removeAttribute("userName");
		session.removeAttribute("phone");
		session.removeAttribute("email");
		response.sendRedirect("login");
		return "login";
	}

	// dashboard page
	@GetMapping(path = "/dashboard")
	public String viewDashboard(HttpSession session, HttpServletResponse response, ModelMap model) throws IOException {
		if (session.getAttribute("userName") != null) {
			model.addAttribute("categories", categoryRepository.findAll());
			return "dashboard";
		}
		response.sendRedirect("login");
		return "login";
	}

	// manage categories page
	@GetMapping(path = "manage_categories")
	public String viewManageCategories(HttpSession session, HttpServletResponse response, ModelMap model)
			throws IOException {
		if (session.getAttribute("userName") != null) {
			model.addAttribute("categories", categoryRepository.findAll());
			return "manage_categories";
		}
		response.sendRedirect("login");
		return "login";
	}

	// delete category
	@PostMapping(path = "delete_category")
	public String deleteCategory(javax.servlet.ServletRequest req, HttpSession session) throws IOException {
		if (session.getAttribute("userName") != null) {

			// get id value of the request
			int id = Integer.parseInt(req.getParameter("id"));

			Iterable<Category> categories = categoryRepository.findAll();
			for (Category category : categories) {
				if (category.getId() == id) {
					categoryRepository.delete(category);
					break;
				}
			}
		}
		return "login";
	}

	// delete product
	@PostMapping(path = "delete_product")
	public String deleteProduct(javax.servlet.ServletRequest req, HttpSession session) throws IOException {
		if (session.getAttribute("userName") != null) {

			// get id value of the request
			int id = Integer.parseInt(req.getParameter("id"));

			Iterable<Product> products = productRepository.findAll();
			for (Product product : products) {
				if (product.getId() == id) {
					productRepository.delete(product);
					break;
				}
			}
		}
		return "login";
	}

	// manage products page
	@GetMapping(path = "manage_products")
	public String viewManageProducts(HttpSession session, HttpServletResponse response, ModelMap model)
			throws IOException {
		if (session.getAttribute("userName") != null) {
			model.addAttribute("products", productRepository.findAll());
			return "manage_products";
		}
		response.sendRedirect("login");
		return "login";
	}

	// order_history page
	@GetMapping(path = "order_history")
	public String viewOrderHistory(HttpSession session, HttpServletResponse response, ModelMap model)
			throws IOException {
		if (session.getAttribute("userName") != null) {
			model.addAttribute("orders", orderRepository.findAll());
			return "order_history";
		}
		response.sendRedirect("login");
		return "login";
	}

	// new order page
	@GetMapping(path = "new_order")
	public String addNewOrder(HttpSession session, HttpServletResponse response, ModelMap model) throws IOException {
		if (session.getAttribute("userName") != null) {
			model.addAttribute("products", productRepository.findAll());
			return "new_order";
		}
		response.sendRedirect("login");
		return "login";
	}

	// save new order
	@PostMapping(path = "new_order")
	public String SaveNewOrder(javax.servlet.ServletRequest req, HttpSession session, HttpServletResponse response,
			ModelMap model) throws IOException {
		if (session.getAttribute("userName") != null) {

			// get values of the request
			String customerName = req.getParameter("cust_name");
			int subTotal = Integer.parseInt(req.getParameter("sub_total"));
			int paid = Integer.parseInt(req.getParameter("paid"));
			int due = Integer.parseInt(req.getParameter("due"));

			Order order = new Order();
			order.setCustomer_name(customerName);
			order.setSubtotal(subTotal);
			order.setPaid(paid);
			order.setDue(due);
			orderRepository.save(order);

			response.sendRedirect("dashboard");
			return "login";
		}
		response.sendRedirect("login");
		return "login";
	}

	@RequestMapping(value = "login", method = RequestMethod.POST)
	public String checkUser(javax.servlet.ServletRequest req, HttpSession session, HttpServletResponse response,
			ModelMap model) throws NoSuchAlgorithmException, IOException {

		// entered email and password
		String email = req.getParameter("email");
		String password = req.getParameter("password");

		// all users of database
		Iterable<User> users = userRepository.findAll();

		// search for entered user
		for (User user : users) {
			String userEmail = user.getEmail();
			if (userEmail.equals(email)) {
				String userPassword = user.getPassword();
				if (userPassword.equals(getHashPass(password))) {
					session.setAttribute("userName", user.getName());
					session.setAttribute("phone", user.getPhone());
					session.setAttribute("email", user.getEmail());
					response.sendRedirect("dashboard");
					break;
				}
			}
		}

		model.addAttribute("classNames", "alert alert-danger");
		model.addAttribute("message", "Incorrect User");
		return "login";
	}

	// encrypt password(plaintext to md5)
	public String getHashPass(String password) throws NoSuchAlgorithmException {

		String plainText = password;
		MessageDigest mdAlgorithm = MessageDigest.getInstance("MD5");
		mdAlgorithm.update(plainText.getBytes());

		byte[] digest = mdAlgorithm.digest();
		StringBuffer hexString = new StringBuffer();

		for (int i = 0; i < digest.length; i++) {
			plainText = Integer.toHexString(0xFF & digest[i]);

			if (plainText.length() < 2) {
				plainText = "0" + plainText;
			}

			hexString.append(plainText);
		}
		return hexString.toString();
	}

	@RequestMapping(value = "save_category", method = RequestMethod.POST)
	public String saveCategory(javax.servlet.ServletRequest req, HttpSession session, HttpServletResponse response)
			throws NoSuchAlgorithmException, IOException {
		if (session.getAttribute("userName") != null) {
			String categoryName = req.getParameter("category_name");
			if (categoryName != null && !categoryName.equals("")) {
				Category category = new Category();
				category.setName(categoryName);
				categoryRepository.save(category);
				response.sendRedirect("dashboard");
				return "login";
			}
		} else {
			response.sendRedirect("login");
		}
		return "login";
	}

	@RequestMapping(value = "save_product", method = RequestMethod.POST)
	public String saveProduct(javax.servlet.ServletRequest req, HttpSession session, HttpServletResponse response)
			throws NoSuchAlgorithmException, IOException {
		if (session.getAttribute("userName") != null) {

			// get all fiels
			String productName = req.getParameter("product_name");
			int productCategoryId = Integer.parseInt(req.getParameter("product_category_id").substring(0,
					req.getParameter("product_category_id").length() - 2));
			;
			ZonedDateTime productDate = ZonedDateTime.parse(req.getParameter("product_date") + " 11:59:00 AM +04:59",
					DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss a z"));
			int productPrice = Integer.parseInt(req.getParameter("product_price"));
			int productQty = Integer.parseInt(req.getParameter("product_qty"));

			// find the category object of the product
			Category selectedCategory = null;
			Iterable<Category> categories = categoryRepository.findAll();
			for (Category category : categories) {
				if (category.getId() == productCategoryId) {
					selectedCategory = category;
					break;
				}
			}

			Product product = new Product();
			product.setName(productName);
			product.setCategory(selectedCategory);
			product.setProduct_date(productDate);
			product.setPrice(productPrice);
			product.setQuantity(productQty);
			productRepository.save(product);

			response.sendRedirect("dashboard");
			return "login";

		} else {
			response.sendRedirect("login");
		}
		return "login";
	}
}