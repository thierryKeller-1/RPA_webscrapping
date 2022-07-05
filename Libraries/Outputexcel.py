import pandas as pd
import os
import shutil

def save_to_excel(page_index:int, datas:dict, target_name:str) -> None:
    
    if is_dict_item_size_is_equal(datas):
        try:
            df = pd.DataFrame(
            {
                "Images Link": datas['image_links'],
                "Status": datas['status'],
                "Marks": datas['marks'],
                "Original Filing Numbers": datas['original_filing_numbers'],
                "Filing Dates": datas['filing_dates'],
                "Publication Numbers": datas['publication_numbers'],
                "Publication Dates": datas['publication_dates'],
                "Original registration Numbers": datas['original_registration_numbers'],
                "Registration Dates": datas['registration_dates'],
                "Nice Classes": datas['nice_classes'],
                "Vienna classes": datas['vienna_classes'],
                "Applicants": datas['applicants'],
                "Designated States": datas['designated_states']
            })
            
            df.to_excel(f"{target_name}_Trademarks_page{page_index}.xlsx")
            print("Data Saved Successfuly")
            return
        except Exception as e:
            print(f"Error {e}")
        return 
    else:
        print("Dict arguments items length doesn't match")
        return

def is_dict_item_size_is_equal(arg:dict) -> bool:
    item_size = len(arg['image_links'])
    print(item_size)

    if len(arg['status']) == item_size and len(arg['marks']) == item_size\
        and len(arg['original_filing_numbers']) == item_size and len(arg['filing_dates']) == item_size\
        and len(arg['publication_numbers']) == item_size and len(arg['publication_dates']) == item_size\
        and len(arg['original_registration_numbers']) == item_size and len(arg['registration_dates']) == item_size\
        and len(arg['nice_classes']) == item_size and len(arg['vienna_classes']) == item_size\
        and len(arg['applicants']) == item_size and len(arg['designated_states']) == item_size:
            return True
    else: return False
    
def create_directory(page_index:int) -> str:
    file_storage_dir = os.path.abspath('data')
    new_page_data_dir = f"{file_storage_dir}\page_{page_index + 1}"
    try:
        if not os.path.exists(new_page_data_dir):
            os.makedirs(new_page_data_dir)
            return new_page_data_dir
        else:
            shutil.rmtree(new_page_data_dir)
            os.makedirs(new_page_data_dir)
            return new_page_data_dir
    except Exception as e:
        print(f"Error when creating new directory {e}")
        return

