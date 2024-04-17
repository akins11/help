`Dashboard app structure`:

+ app.py                             # The dashboard entry point (All files in the app connect to this file)

    - mod_data_input.py

        - Frontend:
            - comp_data_input.py
            - comp_global.py
        
        - Backend:
            - func_data_input.py
            - func_ui_data_input.py  # sarver side user interface (UI)


    - mod_overview.py

        - Frontend:
            - comp_global.py
        
        - Backend:
            - func_overview_backend.py
            - func_rainfall_forecasting_process.py


----
`Folders descriptions`:

+ modules: 
    This folder contains files that are extensions of the `app.py` file. They basically hold code for specific pages in the whole dashboard, such as `mod_overview.py`. This file contains both the user interface (UI) frontend code and the server (backend) code. Therefore, all the code within the `overview_ui()` function in `mod_overview.py` is the UI code for the dashboard page, and the other code within `overview_server()` is the server (backend) code for the dashboard page.

+ components: (UI functions only)
    This folder contains reusable UI component functions. These functions can be used in individual pages (like `comp_data_input.py`) or across multiple pages (like `comp_global.py`). They were originally part of the UI code in files named `mod_*.py` (where * represents a specific name), but have been extracted for better organization and reusability.

+ logic: (Backend functions only)
    The logic folder contains files and functions that make the dashboard not only function properly but also help transform the code from its raw state into a designed output. For example, the `func_overview_backend.py` file contains a set of functions that collect data and return graphs, tables, and card values. While the `func_rainfall_forecasting_process.py` file contains functions that train and forecast future rainfall based on the selected department.

+ data:
    This folder stores the data returned by the data preprocessing pipeline: `climate_crops.csv` and `long_crops.csv` files. It also stores the static data file `rainfall_quantity.csv`.  These files are imported into the dashboard server through `mod_data_input.py` and then passed to `mod_overview.py` to display various outputs and forecast rainfall quantity.

+ www: (UI css only)
    This folder typically contains web app resources like CSS stylesheets, javascripts, images, and fonts. For this dashboard, we only used the `style.css` stylesheet to define the UI elements like cards and page layouts.