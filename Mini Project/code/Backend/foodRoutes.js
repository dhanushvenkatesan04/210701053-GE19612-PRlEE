const express = require('express');
const router = express.Router();
const AddFood = require('../models/Addfood');

///////////////////////////////////////////////////////////////////////////////

router.post('/addfood', async (req, res) => {
  const { foodName, emailId, organisationName, quantity, location, link, foodstatus, recv_emailId } = req.body;
  console.log(foodName);
  try {
    const newFoodItem = new AddFood({
      foodName,
      emailId,
      organisationName,
      quantity,
      location,
      link,
      foodstatus,
      recv_emailId
    });

    await newFoodItem.save();

    res.status(201).json({ message: 'Food item added successfully' });

  } catch (error) {
    console.error('Error adding food item:', error);
    res.status(500).json({ message: 'Internal server error' });
  }
});

///////////////////////////////////////////////////////////////////////////////

router.post('/changestatus', async (req, res) => {
  const { orderId, newStatus } = req.body;

  try {

    const foodItem = await AddFood.findOne({ orderId });

    if (!foodItem) {
      return res.status(404).json({ message: 'Food item not found' });
    }


    foodItem.foodstatus = newStatus;
    await foodItem.save();

    res.status(200).json({ message: 'Food status changed successfully' });
  } catch (error) {
    console.error('Error changing food status:', error);
    res.status(500).json({ message: 'Internal server error' });
  }
});


///////////////////////////////////////////////////////////////////////////////

router.post('/fooditems', async (req, res) => {
  try {
    const foodItems = await AddFood.find();
    res.status(200).json({ foodItems });
  } catch (error) {
    console.error('Error fetching food items:', error);
    res.status(500).json({ message: 'Internal server error' });
  }
});

///////////////////////////////////////////////////////////////////////////////

router.post('/fooditems/:id', async (req, res) => {
  const foodItemId = req.params.id;

  try {
    const deletedFoodItem = await AddFood.findByIdAndDelete(foodItemId);

    if (!deletedFoodItem) {
      return res.status(404).json({ message: 'Food item not found' });
    }

    res.status(200).json({ message: 'Food item deleted successfully' });
  } catch (error) {
    console.error('Error deleting food item:', error);
    res.status(500).json({ message: 'Internal server error' });
  }
});

//////////////////////////////////////////////////////////////////////////////

router.post('/foodItemsWithStatusMinusOne', async (req, res) => {
  try {
   console.log("jndj");
   const foodItems = await AddFood.find({ foodstatus: -1 });
   console.log(foodItems);

    if (!foodItems || foodItems.length === 0) {
      return res.status(404).json({ message: 'No food items found with status -1' });
    }

    res.status(200).json({ foodItems });
  } catch (error) {
    console.error('Error fetching food items with status -1:', error);
    res.status(500).json({ message: 'Internal server error' });
  }
});



module.exports = router;