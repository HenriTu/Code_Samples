from selenium import webdriver
from webdriver_manager.chrome import ChromeDriverManager
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.common.exceptions import TimeoutException
from selenium.webdriver.common.action_chains import ActionChains
from selenium.webdriver.remote.webelement import WebElement
from selenium.webdriver.support import expected_conditions as ec
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.support.ui import Select

import time

class Robot:
    """Contains basic functionalities for Web GUI. The goal is that every interaction is reliable, for example, the clicks."""

    def __init__(self):
        self.driver = webdriver.Chrome(service=Service(ChromeDriverManager().install()))
        self.driver.maximize_window()
        self.actions = ActionChains(self.driver)

    def open(self, url: str):
        """Opens the given URL."""

        self.driver.get(url)

    def quit(self):
        """Quits the current Chrome session."""

        self.driver.quit()

    def click(self, by_object: By, by_string: str, wait_after_click=0.5):
        """Tries to click an element reliably."""

        element: WebElement = self.find_and_scroll_to_element(by_object, by_string)
        self.click_element(element, wait_after_click=wait_after_click)

    def fill(self, by_object: By, by_string: str, value: str):
        """Tries to fill a field reliably."""

        field: WebElement = self.find_and_scroll_to_element(by_object, by_string)
        self.fill_field(field, value)

    def clear_field(self, by_object: By, by_string: str):
        field: WebElement = self.find_and_scroll_to_element(by_object, by_string)
        field.clear()

    def select_by_value(self, by_object: By, by_string: str, value: str):
        select: WebElement = self.find_and_scroll_to_element(by_object, by_string)
        Select(select).select_by_value(value)

    def select_by_visible_text(self, by_object: By, by_string: str, visible_text: str):
        select: WebElement = self.find_and_scroll_to_element(by_object, by_string)
        Select(select).select_by_visible_text(visible_text)

    def wait_for_element(self, by_object: By, by_string: str, max_wait=300):
        """Waits for a certain element. This method is useful if the loading of the page takes some time."""

        self.find_element(by_object, by_string, max_wait=max_wait)
        time.sleep(2)

    def element_exists(self, by_object: By, by_string: str, max_wait=5):
        """Checks if a certain element exists."""

        try:
            self.find_element(by_object, by_string, max_wait=max_wait)
            return True
        except Exception:
            return False

    def wait_until_element_is_not_visible(
        self, by_object: By, by_string: str, max_wait=300
    ):
        """
        Waits until the element is not visible anymore.
        This is useful if you need to wait that some pop-up window dissappears.
        """

        WebDriverWait(self.driver, max_wait).until(
            ec.invisibility_of_element_located((by_object, by_string))
        )
        time.sleep(5)

    def find_element(self, by_object: By, by_string: str, max_wait=60):
        """
        Finds an element using expected condition presence_of_element_located.
        """

        return WebDriverWait(self.driver, max_wait).until(
            ec.presence_of_element_located((by_object, by_string))
        )

    def find_all_elements(self, by_object: By, by_string: str, max_wait=60):
        """
        Finds all elements using expected condition presence_of_all_elements_located.
        """

        return WebDriverWait(self.driver, max_wait).until(
            ec.presence_of_all_elements_located((by_object, by_string))
        )

    def find_clickable_element(self, by_object: By, by_string: str, max_wait=60):
        """
        Finds an element using expected condition element_to_be_clickable.
        """

        return WebDriverWait(self.driver, max_wait).until(
            ec.element_to_be_clickable((by_object, by_string))
        )

    def scroll_to_element(self, element: WebElement, wait_after_scroll=0.5):
        """Scrolls to the given element."""

        self.actions.move_to_element(element).perform()
        time.sleep(wait_after_scroll)

    def click_element(self, element: WebElement, wait_after_click=0.5):
        """Does a basic click and then waits."""

        element.click()
        time.sleep(wait_after_click)

    def fill_field(self, field: WebElement, value: str, wait_time=0.5):
        """First clears the field and then fills it with given value."""

        field.clear()
        time.sleep(wait_time)
        field.send_keys(value)
        time.sleep(wait_time)

    def close_possible_pop_up(self, by_object: By, by_string: str, max_wait=10):
        try:
            self.wait_for_element(by_object, by_string, max_wait=max_wait)
            self.click(by_object, by_string)
        except TimeoutException:  # Did not appear
            pass

    def find_and_scroll_to_element(self, by_object: By, by_string: str) -> WebElement:
        try:
            element: WebElement = self.find_clickable_element(by_object, by_string)
        except TimeoutException:
            element: WebElement = self.find_element(by_object, by_string)

        self.scroll_to_element(element)

        return element
