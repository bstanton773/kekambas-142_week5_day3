from unittest import TestCase, main

from whiteboard import solution


class MatchTestCase(TestCase):
    def test_empty(self):
        self.assertEqual(solution(""),"")
    def test_all_lower_case(self):
        self.assertEqual(solution("ready for testing"),"readyForTesting")
    def test_pascal(self):
        self.assertEqual(solution("I Love Nap Time"),"ILoveNapTime")
    def test_pythonic(self):
        self.assertEqual(solution("lets_go_team"),"letsGoTeam")