# NextGen AI Healthcare

A platform combining AI-powered symptom diagnosis with a volunteer-driven medical rental system for emergencies and routine healthcare needs.


**Live Profiling Report:**

*The `index.html` file contains the y-data profiling report. You can view the live report [here](https://m-saad-0.github.io/fyp_project/).* and kegel notebook [here](https://www.kaggle.com/code/muhammadumarjan/medical-recomendation).* 

**Features:**

* **AI Symptom Diagnosis:**
    * Predicts diseases based on symptoms.
    * Suggests prescriptions, rest, exercise, and diet plans.
* **Medical Rental System:**
    * Rents and facilitates volunteer sharing of medical equipment (BP machines, glucose monitors, etc.).

**Technologies:**

* **Flutter:** Cross-platform mobile and web app development.
* **Node.js:** API handling and user management.
* **Python:** AI models for symptom diagnosis (TensorFlow or PyTorch).

**Setup Instructions (For Developers):**

1. **Flutter Frontend:**
   - Install Flutter: `flutter doctor`
   - Clone the repository and run the app:
     ```bash
     git clone <repo_url>
     cd frontend
     flutter pub get
     flutter run
     ```

2. **Node.js Backend:**
   - Install Node.js (Linux: `sudo apt install nodejs npm`, Windows: `choco install nodejs`)
   - Set up and run the backend:
     ```bash
     git clone <repo_url>
     cd backend
     npm install
     node server.js
     ```

3. **Python AI Service:**
   - Set up Python environment: `python -m venv venv` (activate: Linux/Mac: `source venv/bin/activate`, Windows: `venv\Scripts\activate`)
   - Install dependencies and run the AI service:
     ```bash
     pip install -r requirements.txt
     python app.py
     ```

**Workflow:**

1. Users input symptoms or browse medical rentals through the Flutter app.
2. Node.js backend routes API requests and manages data.
3. Python AI service diagnoses symptoms and sends results to the app.
4. Rental system connects users with equipment providers.

**Revolutionizing healthcare with AI-driven insights and community support.**
