<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Book Session | MindLink</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <style>
        :root { 
            --primary: #003049; 
            --accent-pink: #F497AA; 
            --accent-dark-pink: #D81B60;
            --accent-orange: #F77F00;
            --bg-color: #FFF3E0; 
            --white-glass: rgba(255, 255, 255, 0.9);
            --gray: #e0e0e0; 
        }

        body { 
            font-family: 'Inter', sans-serif; 
            background-color: var(--bg-color); 
            /* 🟢 Attractive Pink Gradient Background */
            background-image: 
                radial-gradient(circle at 10% 20%, rgba(244, 151, 170, 0.15) 0%, transparent 50%),
                radial-gradient(circle at 90% 80%, rgba(247, 127, 0, 0.1) 0%, transparent 50%);
            margin: 0; 
            padding: 40px 20px; 
            color: var(--primary);
            min-height: 100vh;
            position: relative;
            overflow-x: hidden; 
        }
        
        /* 🟢 ANIMATED BLOBS */
        .blob {
            position: absolute; filter: blur(60px); z-index: -1; opacity: 0.7;
            animation: float 10s ease-in-out infinite;
        }
        .blob-1 { top: -50px; left: -50px; width: 500px; height: 500px; background: rgba(244, 151, 170, 0.2); border-radius: 40% 60% 70% 30%; }
        .blob-2 { bottom: -50px; right: -50px; width: 600px; height: 600px; background: rgba(247, 127, 0, 0.15); border-radius: 60% 40% 30% 70%; animation-direction: reverse; }
        
        @keyframes float {
            0% { transform: translate(0, 0) rotate(0deg); }
            50% { transform: translate(20px, 20px) rotate(5deg); }
            100% { transform: translate(0, 0) rotate(0deg); }
        }

        .container { max-width: 1200px; margin: 0 auto; position: relative; z-index: 1; }
        
        .header { text-align: center; margin-bottom: 40px; }
        .header h1 { font-size: 36px; font-weight: 800; margin-bottom: 10px; color: var(--primary); }
        .header p { color: #555; font-size: 16px; }
        
        .layout-grid { display: grid; grid-template-columns: 1fr 1.5fr; gap: 30px; }
        
        /* 🟢 Glass Card Style */
        .card { 
            background: var(--white-glass); 
            backdrop-filter: blur(10px);
            border-radius: 24px; 
            padding: 35px; 
            box-shadow: 0 10px 30px rgba(0,0,0,0.05); 
            border: 1px solid rgba(255,255,255,0.6);
        }
        
        .section-title { 
            font-size: 18px; font-weight: 700; margin-bottom: 20px; 
            border-bottom: 2px solid #eee; padding-bottom: 10px; 
            color: var(--accent-dark-pink);
        }

        /* CALENDAR STYLES */
        .calendar-nav { display: flex; justify-content: space-between; align-items: center; margin-bottom: 15px; font-weight: bold; }
        .nav-btn { cursor: pointer; padding: 5px 10px; user-select: none; transition: 0.2s; }
        .nav-btn:hover { color: var(--accent-pink); transform: scale(1.1); }
        
        .calendar-grid { display: grid; grid-template-columns: repeat(7, 1fr); gap: 8px; text-align: center; }
        .day-label { font-size: 12px; color: #888; font-weight: 600; margin-bottom: 5px; }
        .day-cell { 
            height: 40px; display: flex; align-items: center; justify-content: center; border-radius: 12px; 
            cursor: pointer; transition: 0.2s; font-size: 14px; background: white; border: 1px solid transparent;
        }
        .day-cell:hover:not(.disabled) { background: #ffe0e6; color: var(--accent-dark-pink); border-color: var(--accent-pink); }
        
        /* 🟢 Pink Selected State */
        .day-cell.selected { background: var(--accent-pink); color: white; font-weight: bold; box-shadow: 0 4px 10px rgba(244, 151, 170, 0.4); }
        .day-cell.disabled { color: #ccc; cursor: not-allowed; opacity: 0.4; pointer-events: none; background: #f9f9f9; }

        /* COUNSELOR GRID */
        .counselor-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(140px, 1fr)); gap: 15px; }
        .counselor-card {
            border: 1px solid var(--gray); border-radius: 16px; padding: 15px; text-align: center; cursor: pointer; transition: 0.2s; background: white;
        }
        .counselor-card:hover { border-color: var(--accent-pink); background: #fff5f7; transform: translateY(-3px); }
        
        /* 🟢 Active Counselor Pink */
        .counselor-card.active { 
            background: var(--accent-pink); color: white; border-color: var(--accent-pink); 
            transform: translateY(-3px); box-shadow: 0 5px 15px rgba(244, 151, 170, 0.4); 
        }
        .counselor-icon { font-size: 24px; margin-bottom: 8px; display: block; }

        /* TIME SLOTS */
        .time-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 10px; margin-top: 10px; }
        .time-btn {
            padding: 12px; border: 1px solid var(--gray); border-radius: 12px; text-align: center; 
            font-size: 13px; cursor: pointer; background: white; transition: 0.2s;
        }
        .time-btn:hover:not(.disabled) { border-color: var(--accent-pink); color: var(--accent-dark-pink); }
        .time-btn.active { background: var(--primary); color: white; border-color: var(--primary); }
        .time-btn.disabled { background: #f5f5f5; color: #bbb; cursor: not-allowed; text-decoration: line-through; border-color: #eee; }

        /* MODE SELECTION */
        .mode-selection { display: flex; gap: 15px; margin-top: 15px; }
        .mode-option { flex: 1; position: relative; }
        .mode-option input { position: absolute; opacity: 0; cursor: pointer; }
        .mode-label { 
            display: block; padding: 15px; border: 1px solid var(--gray); border-radius: 12px; 
            text-align: center; cursor: pointer; transition: 0.2s; font-weight: 600; font-size: 14px; background: white;
        }
        .mode-option input:checked + .mode-label {
            background: var(--primary); color: white; border-color: var(--primary); box-shadow: 0 4px 10px rgba(0, 48, 73, 0.2);
        }
        .mode-option:hover .mode-label { border-color: var(--accent-pink); color: var(--accent-dark-pink); }

        /* BUTTONS */
        .action-bar { 
            margin-top: 30px; 
            text-align: right; 
            border-top: 1px solid #eee; 
            padding-top: 20px; 
            display: flex;            
            justify-content: flex-end; 
            gap: 15px;                
        }

        /* 🟢 Gradient Submit Button */
        .submit-btn { 
            background: linear-gradient(135deg, #F497AA, #F77F00); 
            color: white; padding: 15px 40px; font-size: 16px; border: none; border-radius: 50px; 
            cursor: pointer; font-weight: 700; box-shadow: 0 5px 15px rgba(244, 151, 170, 0.4); transition: 0.3s; 
        }
        .submit-btn:hover { transform: translateY(-3px); box-shadow: 0 8px 25px rgba(247, 127, 0, 0.4); }

        .btn-cancel-booking {
            background-color: white; color: #666; border: 1px solid #ddd;
            padding: 15px 30px; font-size: 16px; border-radius: 50px; 
            cursor: pointer; font-weight: 600; text-decoration: none; 
            display: inline-block; transition: 0.2s;
        }
        .btn-cancel-booking:hover { background-color: #f5f5f5; color: #333; }
        
        /* Mobile */
        @media (max-width: 900px) {
            .layout-grid { grid-template-columns: 1fr; }
            .time-grid { grid-template-columns: repeat(3, 1fr); }
        }
    </style>
</head>
<body>

    <div class="blob blob-1"></div>
    <div class="blob blob-2"></div>

    <div class="container">
        
        <a href="${pageContext.request.contextPath}/counseling/home" style="text-decoration: none; color: #666; font-weight: 600; display: inline-flex; align-items: center; margin-bottom: 10px;">
            <i class="fas fa-arrow-left" style="margin-right: 8px;"></i> Back to Dashboard
        </a>

        <div class="header">
            <h1>Book Your Session</h1>
            <p>Select a date, choose your preferred counselor, and pick a time.</p>
        </div>

        <form action="${pageContext.request.contextPath}/counseling/booking/submit" method="post" onsubmit="return validateForm()">
            <input type="hidden" name="date" id="selectedDate">
            <input type="hidden" name="time" id="selectedTime">
            <input type="hidden" name="counselor" id="selectedCounselor">
            <input type="hidden" name="existingId" value="${rescheduleId}">

            <div class="layout-grid">
                
                <div class="card">
                    <div class="section-title">1. Select Date</div>
                    <div class="calendar-nav">
                        <span class="nav-btn" id="prevMonth">&lt;</span>
                        <span id="monthYear">Loading...</span>
                        <span class="nav-btn" id="nextMonth">&gt;</span>
                    </div>
                    <div class="calendar-grid">
                        <div class="day-label">Su</div><div class="day-label">Mo</div><div class="day-label">Tu</div>
                        <div class="day-label">We</div><div class="day-label">Th</div><div class="day-label">Fr</div><div class="day-label">Sa</div>
                    </div>
                    <div class="calendar-grid" id="calendarDays"></div>
                </div>

                <div class="card">
                    <div class="section-title">2. Choose Counselor</div>
                    
                    <div class="counselor-grid">
                        <c:forEach items="${counselors}" var="c">
                            <div class="counselor-card ${c.name == preselectedName ? 'active' : ''}" 
                                 onclick="selectCounselor(this, '${c.name}')">
                                <span class="counselor-icon">🎓</span>
                                <strong>${c.name}</strong>
                            </div>
                        </c:forEach>
                        <c:if test="${empty counselors}">
                            <p style="grid-column: 1/-1; color: red;">No counselors found.</p>
                        </c:if>
                    </div>

                    <div class="section-title" style="margin-top: 30px;">3. Select Time</div>
                    <div class="time-grid" id="timeSlotContainer"></div>

                    <div class="section-title" style="margin-top: 30px;">4. Select Mode</div>
                    <div class="mode-selection">
                        <label class="mode-option">
                            <input type="radio" name="mode" value="Online">
                            <span class="mode-label"><i class="fas fa-video"></i> Online (Webex)</span>
                        </label>
                        <label class="mode-option">
                            <input type="radio" name="mode" value="Physical">
                            <span class="mode-label"><i class="fas fa-building"></i> Physical (Room 314)</span>
                        </label>
                    </div>
                    
                    <div class="action-bar">
                        <a href="${pageContext.request.contextPath}/counseling/home" class="btn-cancel-booking">Cancel</a>
                        <button type="submit" class="submit-btn">Confirm Booking</button>
                    </div>
                </div>
            </div>
        </form>
    </div>

<script>
    // --- 1. GLOBAL VARIABLES ---
    var bookedSlots = [];
    
    // Inject JSP data into JS array
    <c:forEach items="${bookedAppointments}" var="app">
        bookedSlots.push({ 
            date: "${app.date}", 
            time: "${app.time}", 
            counselor: "${app.counselorName}" 
        });
    </c:forEach>

    let currentDate = new Date();
    let currYear = currentDate.getFullYear();
    let currMonth = currentDate.getMonth();
    let pickedDate = ""; 
    let pickedCounselor = "${preselectedName}"; // Auto-select logic

    // Important: Initialize month names
    const months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];

    // Set hidden input if auto-selected
    if (pickedCounselor) {
        document.getElementById("selectedCounselor").value = pickedCounselor;
    }

    // --- 2. RENDER CALENDAR (WITH DISABLE PAST DATES LOGIC) ---
    function renderCalendar() {
        let firstDay = new Date(currYear, currMonth, 1).getDay();
        let lastDate = new Date(currYear, currMonth + 1, 0).getDate();
        
        document.getElementById("monthYear").innerText = months[currMonth] + " " + currYear;
        
        let daysHTML = "";
        
        let today = new Date();
        today.setHours(0, 0, 0, 0);

        for (let i = 0; i < firstDay; i++) {
            daysHTML += '<div class="day-cell disabled"></div>';
        }

        for (let i = 1; i <= lastDate; i++) {
            let m = String(currMonth + 1).padStart(2, '0');
            let d = String(i).padStart(2, '0');
            let dateStr = currYear + "-" + m + "-" + d;
            
            let cellDate = new Date(currYear, currMonth, i);
            
            if (cellDate < today) {
                daysHTML += '<div class="day-cell disabled">' + i + '</div>';
            } 
            else {
                let activeClass = (dateStr === pickedDate) ? "selected" : "";
                daysHTML += '<div class="day-cell ' + activeClass + '" onclick="selectDate(this, \'' + dateStr + '\')">' + i + '</div>';
            }
        }
        document.getElementById("calendarDays").innerHTML = daysHTML;
    }

    document.getElementById("prevMonth").onclick = () => { currMonth--; if(currMonth<0){currMonth=11;currYear--;} renderCalendar(); };
    document.getElementById("nextMonth").onclick = () => { currMonth++; if(currMonth>11){currMonth=0;currYear++;} renderCalendar(); };
    
    // --- 3. SELECTION FUNCTIONS ---
    window.selectDate = function(el, dateStr) {
        pickedDate = dateStr;
        document.getElementById("selectedDate").value = dateStr;
        renderCalendar();
        refreshTimeSlots();
    };

    window.selectCounselor = function(el, name) {
        pickedCounselor = name;
        document.getElementById("selectedCounselor").value = name;
        document.querySelectorAll(".counselor-card").forEach(c => c.classList.remove("active"));
        el.classList.add("active");
        refreshTimeSlots();
    };

    function generateTimeSlots() {
        let slots = [];
        for (let h = 9; h <= 16; h++) {
            let suffix = h >= 12 ? "PM" : "AM";
            let displayH = h > 12 ? h - 12 : h;
            slots.push(String(displayH).padStart(2, '0') + ":00 " + suffix);
            if (h !== 16) slots.push(String(displayH).padStart(2, '0') + ":30 " + suffix);
        }
        return slots;
    }

    function refreshTimeSlots() {
        let container = document.getElementById("timeSlotContainer");
        container.innerHTML = "";
        let allSlots = generateTimeSlots();
        allSlots.forEach(time => {
            let isTaken = false;
            if (pickedDate && pickedCounselor) {
                isTaken = bookedSlots.some(b => b.date === pickedDate && b.time === time && b.counselor === pickedCounselor);
            }
            
            let disabledClass = isTaken ? "disabled" : "";
            let clickAction = isTaken ? "" : "selectTime(this, '" + time + "')";
            
            container.innerHTML += '<div class="time-btn ' + disabledClass + '" onclick="' + clickAction + '">' + time + '</div>';
        });
    }

    window.selectTime = function(el, time) {
        document.getElementById("selectedTime").value = time;
        document.querySelectorAll(".time-btn").forEach(b => b.classList.remove("active"));
        el.classList.add("active");
    };

    function validateForm() {
        let modeSelected = document.querySelector('input[name="mode"]:checked');

        if(!pickedDate || !pickedCounselor || !document.getElementById("selectedTime").value || !modeSelected) {
            alert("Please complete all fields:\n- Date\n- Counselor\n- Time\n- Session Mode");
            return false;
        }
        return true;
    }

    // --- 4. INITIALIZE ---
    renderCalendar();
    refreshTimeSlots();
</script>

</body>
</html>