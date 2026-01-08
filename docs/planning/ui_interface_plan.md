# 4-in-1 Real Estate Management SaaS - UI Interface Plan

This document outlines the User Interface (UI) structure and flow for the four key user roles: **Owner**, **Agent**, **Renter**, and **Buyer**, based on the project requirements.

## 1. Global Landing Page & Authentication

### Layout Structure
- **Split Screen Design**:
    - **Left Side**: Registration & Login Forms.
        - **Registration**:
            - Options: Google, Facebook, Phone Number.
        - **Login**:
            - **Renter/Buyer**: Email + Phone Verification Code.
            - **Owner/Agent**: Email/Phone + Password (implied standard auth).
    - **Right Side**: 4-Quadrant Navigation Grid.
        1.  **Top-Left**: **Owner** Entry.
        2.  **Top-Right**: **Agent** Entry.
        3.  **Bottom-Left**: **Renter** Entry.
        4.  **Bottom-Right**: **Buyer** Entry.

---

## 2. Owner Portal UI
*Slogan: "We help Owner build their Property Marketing AI Agent"*

### A. Dashboard Overview (Home)
**Layout**: Sidebar Navigation + Top Header + Main Content Area.
- **Top Header**: User Profile, Notifications, "Ask Docs AI" Helper button.
- **Widgets**:
    - **Financial Summary**: Recent Income/Expenses, Pending Rent.
    - **Property Status**: Occupancy Rate, Maintenance Requests (Active).
    - **Quick Actions**: "List New Property", "Create Marketing Page".
    - **Messages**: Recent inquiries from Renters/Buyers.
    - **Calendar**: Upcoming inspections/maintenance.

### B. Navigation Menu Structure
1.  **Dashboard**
2.  **My Properties**
    - List View of all properties.
    - Status indicators (Leased, Vacant, Maintenance).
    - **Single Property Detail View**:
        - **Marketing Tab**: 
            - "One-Click Generate Webpage" (Template selection).
            - Upload 2D/3D/Video Tours.
            - Custom Questions setup.
        - **Lease Tab**:
            - Current Lease Agreement (Preview/Cloud Store).
            - Tenant Insurance Status.
        - **Maintenance Tab**: Track requests and history.
        - **Settings**: Call Forwarding toggle, Blocklist management.
3.  **Tenant Screening**
    - Application review pipeline.
    - Credit/Background check results.
4.  **Financials**
    - **In/Out Report**: Income vs Expenses charts.
    - **Rent Roll**: Payment status per tenant.
    - **Expense Manager**: Upload receipts, categorize expenses.
    - **Tax**: ATO-compliant Tax Report Generator.
    - **Banking**: Linked Bank Accounts management.
5.  **Messages**
    - Unified Inbox (Renters, Buyers).
    - Message Filters.
6.  **Services**
    - Rent Guarantee Program (Activation & Status).
    - Professional Photography/Tour Orders.

### C. Key Features UI Details
- **Docs AI Helper**: Floating button (bottom-right) on every page. clicking opens a chat window to explain the current document or page function.
- **Call Forwarding Controls**: Simple Toggle Switch "Forward Calls to Mobile" (On/Off).
- **Appointment Booking**: Notifications show "New Inspection Booked"; Calendar view highlights booked slots.

---

## 3. Agent Portal UI
*Slogan: "We help Real Estate Agent build their Personal Marketing AI Agent"*

### A. Dashboard Overview (Home)
**Layout**: Similar to Owner but focused on Agent Branding and Portfolio.
- **Widgets**:
    - **Lead Pipeline**: New inquiries count.
    - **Commission/Revenue**: Monthly performance.
    - **Active Listings**: Number of properties on market.
    - **Task List**: Follow-ups, Lease renewals.

### B. Navigation Menu Structure
1.  **Dashboard**
2.  **Profile & Branding** (Personal Marketing AI)
    - **Personal Intro**: Bio, Photo, Service Areas, Achievements (for Home Page display).
    - **Brand Color/Logo Settings** for generated pages.
3.  **Listing Management** (List Your Property)
    - Similar to Owner's Property management but assumes Agency context.
    - **Templates**: Professional marketing templates selection.
    - **Media Library**: 2D/3D/Video assets.
4.  **CRM / Leads**
    - **Inbox**: Messages from Renters/Buyers.
    - **Contacts**: Database of past/current clients.
    - **Screening**: Tenant Screening tools.
    - **Appointment Manager**: "Leave a message to book" system management.
5.  **Financials & Reporting**
    - **Rent Payments**: Manages payments for managed properties.
    - **Revenue Reports**: Commission tracking.
    - **ATO Reports**: Tax generation for owners (Agent facilitated).
6.  **Tools & Services**
    - **Blacklist Manager**: Phone number blocking (User/Peer).
    - **Call Forwarding**: Agent line routing.
    - **Insurance & Maintenance**: System integration.
    - **Rent Guarantee**: Policy management for managed properties.
    - **Lease Generator**: Unlimited Lease Agreement tools.

---

## 4. Renter Interface UI

### A. Home Page (Search)
- **Search Bar**: Location, Price, Property Type, Move-in Date.
- **Results Grid**: Cards showing Property Image, Price, Address, Key features.
- **Filters**: Pet-friendly, Parking, Furnished, etc.

### B. Property Detail Page
- **Hero Section**: High-res Images/Video/3D Tour.
- **Information**: Description, Amenities, "Custom Questions" FAQ section.
- **Action Buttons**: 
    - "Book Inspection" (Select time slot).
    - "Apply Now" (Starts screening process).
    - "Ask a Question" (Messaging).
- **Agent/Owner Profile**: Small bio card of the listing manager.

### C. Renter Dashboard (After Login)
1.  **My Applications**: Status of submitted applications.
2.  **My Home** (If lease active):
    - **Lease Info**: Download Contract.
    - **Rent Payment**: Pay Now (Credit/Debit/PayID), Auto-pay setup.
    - **Service Request**: "Report Issue" (Maintenance).
3.  **Messages**: Chat with Landlord/Agent.

---

## 5. Buyer Interface UI

### A. Home Page (Search)
- **Search Bar**: Location, Price, Property Type (Buy), Bedrooms.
- **Map View**: Interactive map showing listed properties.

### B. Property Detail Page
- **Visuals**: Focus on 3D Tours and Video.
- **Details**: Floor plan, Land size, Rates, "Custom Questions".
- **Action Buttons**:
    - "Book Viewing".
    - "Make an Offer" (Optional feature if applicable).
    - "Contact Agent".

### C. Buyer Dashboard
1.  **Saved Properties**: Favorites list.
2.  **My Viewings**: Calendar of upcoming appointments.
3.  **Messages**: Chat history with Agents/Owners.
4.  **Offers**: Status of any offers made.

---

## Common UI Elements
- **Ask Docs AI**: Context-aware help accessible globally.
- **Responsive Design**: Mobile-first approach for Renters/Buyers; Desktop-optimized for Owners/Agents management tools.
- **Visual Style**: Modern, clean, professional. Trust-building colors (Blues, Greens, or custom Brand colors).
