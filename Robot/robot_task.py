from robot import Robot
from selenium.webdriver.common.by import By
import time

robot = Robot()
robot.open("https://www.manifoldmath.com/")
time.sleep(2)
robot.click(By.XPATH, "//button[text()='Compute']")
robot.wait_for_element(By.XPATH, "//a[text()='Go Back']")
robot.click(By.XPATH, "//a[text()='Go Back']")
robot.select_by_value(By.ID, "dimension", "2")
robot.fill(By.ID, "coordinates", "theta phi")
robot.fill(By.ID, "cell-0-0", "1")
robot.fill(By.ID, "cell-1-1", "sin^2(theta)")
robot.click(By.XPATH, "//button[text()='Compute']")
robot.wait_for_element(By.XPATH, "//a[text()='Go Back']")
robot.click(By.XPATH, "//a[text()='Go Back']")
robot.click(By.XPATH, "//a[@class='navbar-brand']")
time.sleep(2)